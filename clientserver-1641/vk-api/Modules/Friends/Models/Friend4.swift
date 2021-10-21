//
//  Friend4.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 21.10.2021.
//

import Foundation

// MARK: - Codable + SwiftyJSON

struct Friend4: Codable {
    let id: Int
    let lastName: String
    let firstName: String
    let photo100: String
    
    var fullName: String {
        firstName + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case firstName = "first_name"
        case photo100 = "photo_100"
    }
}
