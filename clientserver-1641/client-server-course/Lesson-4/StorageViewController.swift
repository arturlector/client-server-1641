//
//  StorageViewController.swift
//  clientserver-1641
//
//  Created by Artur Igberdin on 25.10.2021.
//

import UIKit
import SwiftKeychainWrapper
import CoreData
import RealmSwift

class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var userId: String = ""
    @objc dynamic var token: String = ""
}

class StorageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //useUserDefaults()
        //useKeychain()
        //useCoreData()
        
        useRealm()
    }
    
    func useUserDefaults() {
        
        let stepForm = UserDefaults.standard.integer(forKey: "stepForm")
        let isOnboarded = UserDefaults.standard.bool(forKey: "isOnboarded")
        
        print(stepForm, isOnboarded)
        
        UserDefaults.standard.set(3, forKey: "stepForm")
        UserDefaults.standard.set(true, forKey: "isOnboarded")
    }
    
    func useKeychain() {
        
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        
        print(token ?? "")
        
        KeychainWrapper.standard.set("qwer12345asdf1345", forKey: "token")
    }
    
    func useCoreData() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        // 1 шаг - загрузить объект в БД
        
        let newHuman = Human(context: context)
        newHuman.name = "Jack"
        newHuman.gender = true
        newHuman.birthday = Date()
        
        appDelegate.saveContext()
        
        // 2 шаг - выгрузили  объект
        let results = try! context.fetch(Human.fetchRequest()) as! [Human]
        let human = results.first!
        print(human)
    }
    
    func useRealm() {
        
        let user = User()
        user.name = "Kolobok"
        user.token = "12342345asefrsdf24323rsdffaasfd"
        user.userId = "1243524134"
        
        let migration = Realm.Configuration(schemaVersion: 2)
        let realm = try! Realm(configuration: migration)
        
        // 1 шаг - сохранение объекта в Realm
        realm.beginWrite()
        realm.add(user)
        try! realm.commitWrite()
        
        // 2 шаг - считываем объект
        let users = realm.objects(User.self)
        users.forEach { print($0.name, $0.token, $0.userId) }
        
    }

}
