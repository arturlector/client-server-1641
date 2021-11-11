//
//  Friend1.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 21.10.2021.
//

import Foundation

//

// MARK: - JSONSerialization

struct Friend1 {
    
    var id: Int = 0
    var firstName: String?
    var lastName: String?
    var photo100: String?
    
    var fullName: String {
        (firstName ?? "") + (lastName ?? "")
    }
    
    init(item: [String: Any]) {
        self.id = item["id"] as! Int
        self.firstName = item["first_name"] as? String
        self.lastName = item["last_name"] as? String
        self.photo100 = item["photo_100"] as? String
    }
}
