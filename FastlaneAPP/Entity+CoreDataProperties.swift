//
//  Entity+CoreDataProperties.swift
//  FastlaneAPP
//
//  Created by Swift-Beginners on 2021/05/26.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var attribute: Int32

}

extension Entity : Identifiable {

}
