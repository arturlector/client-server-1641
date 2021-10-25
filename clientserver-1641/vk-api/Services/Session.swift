//
//  Session.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 18.10.2021.
//

import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    
    static let shared = Session()
    
    //Keychain
    var token: String {
        set {
            KeychainWrapper.standard.set(newValue, forKey: "userId")
        }
        get {
            return KeychainWrapper.standard.string(forKey: "userId") ?? ""
        }
    }
    
    //UserDefaults
    var userId: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
    }
}
