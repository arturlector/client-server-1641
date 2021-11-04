//
//  PersonDB.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 01.11.2021.
//

import Foundation
import RealmSwift

//FriendsDB, GroupDB, PhotoDB
final class FriendsDB {
    
    init() {
        Realm.Configuration.defaultConfiguration = Realm.Configuration(schemaVersion: 7)
    }

    func save(_ items: [FriendModel]) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(items)
        }
    }
    
    func load() -> Results<FriendModel> {
        let realm = try! Realm()
        let friends: Results<FriendModel> = realm.objects(FriendModel.self)
        return friends
    }
    
    func delete(_ item: FriendModel) {
        let realm = try! Realm()
        
        //Асинхронное API
        try! realm.write {
            realm.delete(item)
        }
    }
}

