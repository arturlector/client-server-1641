//
//  FriendsAPI.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import Foundation
import Alamofire

struct Friend {
    
}

final class FriendsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"
    
    func getFriends(completion: @escaping([Friend])->()) {
        
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
            
            print(response.value)
        }
    }
}
