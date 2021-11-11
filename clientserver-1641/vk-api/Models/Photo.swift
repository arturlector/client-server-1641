//
//  Photo.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 11.11.2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let photoJSON = try? newJSONDecoder().decode(PhotoJSON.self, from: jsonData)

import Foundation


// MARK: - Photo
struct Photo: Codable {
    let albumID: Int
    let reposts: Reposts
    let postID, id, date: Int
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let likes: Likes

    //Большой картинки
    var photoUrl: String {
        guard let size = sizes.last else { return ""}
        return size.url
    }
    
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case reposts
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case likes
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
