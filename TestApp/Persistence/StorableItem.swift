//
//  StorableItem.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import CoreData

extension Item: Entity {
    public func toStorable(in context: NSManagedObjectContext) -> CDItem {
        let coreDataItem = CDItem.getOrCreateSingle(with: title, from: context)
        coreDataItem.uuid = uuid
        coreDataItem.createdAt = createdAt
        coreDataItem.title = title
        coreDataItem.isSelected = isSelected
        return coreDataItem
    }
}

extension CDItem: Storable {
    var model: Item {
        get {
            return Item(uuid: uuid, title: title, isSelected: isSelected, createdAt: createdAt)
        }
    }
}

extension Storable where Self: NSManagedObject {
    
    static func getOrCreateSingle(with uuid: String, from context: NSManagedObjectContext) -> Self {
        let result = single(with: uuid, from: context) ?? insertNew(in: context)
        result.setValue(uuid, forKey: "uuid")
        return result
    }
    
    static func single(with uuid: String, from context: NSManagedObjectContext) -> Self? {
        return fetch(with: uuid, from: context)?.first
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        return Self(context:context)
    }
    
    static func fetch(with uuid: String, from context: NSManagedObjectContext) -> [Self]? {
        let entityName = String(describing: Self.self)
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "uuid == %@", uuid)
        fetchRequest.fetchLimit = 1

        let result: [Self]? = try? context.fetch(fetchRequest)
        
        return result
    }
}
