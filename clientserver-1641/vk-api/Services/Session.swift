//
//  Session.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import Foundation

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    var token = ""
    var userId = ""
}
