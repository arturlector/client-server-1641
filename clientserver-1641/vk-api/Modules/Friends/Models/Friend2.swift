//
//  Friend2.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 21.10.2021.
//

import Foundation
import SwiftyJSON

// MARK: - SwiftyJSON
//
struct Friend2 {
    
    var id: Int = 0
    var firstName: String = ""
    var lastName: String = ""
    var photo100: String = ""
    
    var fullName: String {
        firstName + lastName
    }
    
    init(json: JSON) {
        self.id = json["id"].intValue
        self.firstName = json["first_name"].string ?? ""
        self.lastName = json["last_name"].string ?? ""
        self.photo100 = json["photo_100"].string ?? ""
    }
}
