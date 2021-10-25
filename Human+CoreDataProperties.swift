//
//  Human+CoreDataProperties.swift
//  
//
//  Created by Artur Igberdin on 25.10.2021.
//
//

import Foundation
import CoreData


extension Human {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Human> {
        return NSFetchRequest<Human>(entityName: "Human")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var gender: Bool
    @NSManaged public var name: String?

}
