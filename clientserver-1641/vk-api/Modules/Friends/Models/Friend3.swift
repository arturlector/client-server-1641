//
//  Friend3.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 21.10.2021.
//

import Foundation

// MARK: - Codable

struct FriendsJSON: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Friend3]
}

// MARK: - Item
struct Friend3: Codable {
    let id: Int
    let lastName: String
    let photo50: String
    let trackCode, firstName: String
    let photo100: String
    let deactivated: String?
    
    var fullName: String {
        firstName + lastName
    }

    enum CodingKeys: String, CodingKey {
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case firstName = "first_name"
        case photo100 = "photo_100"
        case deactivated
    }
}
