//
//  PhotoAPI.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

final class PhotosAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"

    
    func getPhotos(completion: @escaping([PhotoModel])->()) {
        
        let method = "/photos.getAll"
        
        let parameters: Parameters = [
            "owner_id": userId,
            "extended": 1,
            "count": 10,
            "no_service_albums": 0,
            "access_token": token,
            "v": version
        ]
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON { response in
            
            //Бинарник с данными
            guard let data = response.data else { return }
        
            debugPrint(data.prettyJSON ?? "")
            
            do {
                let itemsData = try JSON(data)["response"]["items"].rawData()
                
                //Уже рилмовский объект
                var photos = try JSONDecoder().decode([PhotoModel].self, from: itemsData)
                
                for photo in photos {
                    photo.assetUrl = photo.photoUrl
                }
                
                completion(photos)
            } catch {
                print(error)
            }
        }
    }
}
