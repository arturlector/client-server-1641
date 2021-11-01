//
//  PersonDB.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 01.11.2021.
//

import Foundation
import RealmSwift

class PersonModel: Object {
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var pet = ""
    @objc dynamic var weapon = ""
    var car = "" //сохраняться не будет
}

protocol PersonDBProtocol {
    //CRUD - create, read, update, delete
    
    func create(_ person: PersonModel)
    func read() -> [PersonModel]
    func delete(_ person: PersonModel)
}

//FriendsDB, GroupDB, PhotoDB
class PersonDB: PersonDBProtocol {
    
    //Сохранить
    let migration = Realm.Configuration(schemaVersion: 6) //миграция работает как на расширение так и на уделение
    lazy var mainRealm = try! Realm(configuration: migration)
    
    func create(_ person: PersonModel) {
        do {
            mainRealm.beginWrite()
            mainRealm.add(person) //добавляем объект в хранилище
            try mainRealm.commitWrite()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [PersonModel] {
        
        let persons = mainRealm.objects(PersonModel.self)
        persons.forEach { print($0.name, $0.age) }
        print(mainRealm.configuration.fileURL ?? "")
        return Array(persons) //враппим Result<> в Array<>
    }
    
    func delete(_ person: PersonModel) {
        do {
            mainRealm.beginWrite()
            mainRealm.delete(person)
            try mainRealm.commitWrite()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}

