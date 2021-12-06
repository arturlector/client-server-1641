//
//  PromiseKitViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 06.12.2021.
//

import UIKit
import Alamofire
import PromiseKit

struct Writer: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
}

struct Post: Codable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}

enum ApplicationError: Error {
    case noUsers
    case noPosts
    case postsCouldNotBeParsed
}

final class PostAPI {
    
    func getAllWriters() -> Promise<[Writer]> {
        return Promise<[Writer]> { resolver in
            
            let url = "https://jsonplaceholder.typicode.com/users"
            AF.request(url).responseJSON { response in
                if let error = response.error {
                    resolver.reject(error)
                }
                if let data = response.data {
                    do {
                        let users = try JSONDecoder().decode([Writer].self, from: data)
                        resolver.fulfill(users)
                    } catch {
                        resolver.reject(ApplicationError.noUsers)
                    }
                }
            }
        }
    }
    
    func getPosts(for writerId: Int) -> Promise<[Post]> {
        return Promise<[Post]> { resolver in
            
            let url = "https://jsonplaceholder.typicode.com/posts"
            AF.request(url).responseJSON { response in
                if let error = response.error {
                    resolver.reject(error)
                }
                if let data = response.data {
                    do {
                        let posts = try JSONDecoder().decode([Post].self, from: data)
                        resolver.fulfill(posts)
                    } catch {
                        resolver.reject(ApplicationError.noPosts)
                    }
                }
            }
        }
    }
    
    
    
}

class PromiseKitViewController: UIViewController {

    let postAPI = PostAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Cтартанули лоадер
        
        firstly {
            postAPI.getAllWriters()
        }.then { writers in
            self.postAPI.getPosts(for: writers[0].id)
        }.then { posts in
            self.postAPI.getPosts(for: 3)
        }
        .ensure {
            //лоадер завершить
        }.done { posts in
            print(posts)
            //Выводим на UI
        }.catch { error in
            print(error)
            //Отработаем ошибку
        }
        
    }


}
