//
//  GroupsAPI.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import Foundation
import Alamofire

struct Group {
    
}

class GroupsAPI {
    
    let baseUrl = "https://api.vk.com/method"
    
    let token = Session.shared.token
    let userId = Session.shared.userId
    let version = "5.81"
    
    func getGroups(completion: @escaping([Group])->()){
        
        let method = "/groups.get"
        
        let parameters: Parameters = [
            "user_id": userId,
            "extended": 1,
            "fields": "city, activity, verified",
            "count": 5,
            "access_token": token,
            "v": version,
        ]
        let url = baseUrl + method
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: { response in
            print("Response: \(response.value)")
        })
        
    }
    
    func searchGroups(query: String, completion: @escaping([Group])->()) {
        
        let method = "/groups.search"
        
        let parameters: Parameters = [
            "q": query,
            "type": "group",
            "count": 5,
            "access_token": token,
            "v": version,
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get, parameters: parameters).responseJSON(completionHandler: { response in
            print("Response: \(response.value)")
        })
    }
    
}
