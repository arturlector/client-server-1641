//
//  FriendsAPI.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"
    
    
    func getFriends4(completion: @escaping([FriendModel])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50, photo_100",
            "count": 100,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            //Бинарник всего JSON
            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                
                //Подбинарник только items
                let itemsData = try JSON(data)["response"]["items"].rawData()
                let friends = try JSONDecoder().decode([FriendModel].self, from: itemsData)
          
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }
    

    func getFriends3(completion: @escaping([Friend3])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50, photo_100",
            "count": 10,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON as Any)
            
            do {
                
                let friendsJSON = try JSONDecoder().decode(FriendsJSON.self, from: data)
                let friends: [Friend3] = friendsJSON.response.items
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }
    
    
    
    func getFriends2(completion: @escaping([Friend2])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50, photo_100",
            "count": 10,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in

            guard let data = response.data else { return }
            debugPrint(response.data?.prettyJSON)
            
            do {
                guard let items = JSON(data)["response"]["items"].array else { return }
                let friends = items.map { Friend2(json: $0) }
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }
    
    func getFriends(completion: @escaping([Friend1])->()) {
        
        let method = "/friends.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "order": "name",
            "fields": "photo_50, photo_100",
            "count": 10,
            "access_token": token,
            "v": version
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            //JSONSerialization
            
            guard let data = response.data else { return }
    
            debugPrint(response.data?.prettyJSON)
            
            do {
                
                let jsonContainer: Any =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                
                let object = jsonContainer as! [String: Any]
                
                let response = object["response"] as! [String: Any]
                
                let items = response["items"] as! [Any]
                
                //Массив друзей
//                var friends: [Friend1] = []
//                for item in items {
//                    let friend = Friend1(item: item as! [String: Any])
//                    friends.append(friend)
//                }
                
                let friends = items.map { Friend1(item: $0 as! [String: Any]) }
                completion(friends)
                
            } catch {
                print(error)
            }
        }
    }
}
