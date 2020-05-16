//
//  DataSourceProtocols.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import CoreData

protocol DataSourceProtocol {
    associatedtype EntityObject: Entity
    
    func getAll(where predicate: NSPredicate?) throws -> [EntityObject]
    func insert(item: EntityObject) throws
    func update(item: EntityObject) throws
    func delete(item: EntityObject) throws
}

extension DataSourceProtocol {
    func getAll() throws -> [EntityObject] {
        return try getAll(where: nil)
    }
}

protocol Entity {
    associatedtype StoreType: Storable
    
    var uuid: String { get }
    func toStorable(in context: NSManagedObjectContext) -> StoreType
}

protocol Storable {
    associatedtype EntityObject: Entity
    
    var model: EntityObject { get }
    var uuid: String { get }
    var createdAt: Date { get }
}
