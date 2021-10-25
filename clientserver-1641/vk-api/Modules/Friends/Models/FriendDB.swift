//
//  Friend4.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 21.10.2021.
//

import Foundation
import RealmSwift

// MARK: - Codable + SwiftyJSON

class FriendDB: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var lastName: String
    @objc dynamic var firstName: String
    @objc dynamic var photo100: String
    
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
