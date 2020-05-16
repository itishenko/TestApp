//
//  DataSource.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import CoreData

class DataSource<RepositoryObject>: DataSourceProtocol
        where RepositoryObject: Entity,
        RepositoryObject.StoreType: NSManagedObject,
        RepositoryObject.StoreType.EntityObject == RepositoryObject {

    var persistentContainer: NSPersistentContainer

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func getAll(where predicate: NSPredicate?) throws -> [RepositoryObject] {
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        let objects = try getManagedObjects(with: predicate, sort: sort)
        return objects.compactMap { $0.model }
    }

    func insert(item: RepositoryObject) throws {
        persistentContainer.viewContext.insert(item.toStorable(in: persistentContainer.viewContext))
        saveContext()
    }
    
    func update(item: RepositoryObject) throws {
        try delete(item: item)
        try insert(item: item)
    }
    
    func delete(item: RepositoryObject) throws {
        let predicate = NSPredicate(format: "uuid == %@", item.uuid) 
        let items = try getManagedObjects(with: predicate)
        
        persistentContainer.viewContext.delete(items.first!)
        saveContext()
    }
    
    private func getManagedObjects(with predicate: NSPredicate?, sort: NSSortDescriptor? = nil) throws -> [RepositoryObject.StoreType] {
        let entityName = String(describing: RepositoryObject.StoreType.self)
        let request = NSFetchRequest<RepositoryObject.StoreType>(entityName: entityName)
        request.predicate = predicate
        if let sort = sort {
            request.sortDescriptors = [sort]
        }
        return try persistentContainer.viewContext.fetch(request)
    }
    
    // MARK: - Core Data Saving support
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
