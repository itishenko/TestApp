//
//  CDItem.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import CoreData

@objc(CDItem)
public class CDItem: NSManagedObject {}

extension CDItem {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDItem> {
        return NSFetchRequest<CDItem>(entityName: "CDItem")
    }
    
    @NSManaged public var uuid: String
    @NSManaged public var createdAt: Date
    @NSManaged public var title: String
    @NSManaged public var isSelected: Bool
}
