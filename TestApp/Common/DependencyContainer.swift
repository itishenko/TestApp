//
//  DependencyContainer.swift
//  TestApp
//
//  Created by Ivan Tischenko on 11.01.2021.
//  Copyright © 2021 itishenko. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DependencyContainer {
    lazy var itemDataSource = DataSource<Item>(persistentContainer: persistentContainer)
    lazy var diskCatalogService = CDCatalogService(urlSession: URLSession.shared, parser: XMLItemListParser<CompactDisk>())
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestApp")
        container.loadPersistentStores(completionHandler: { [weak self] storeDescription, error in
            if let error = error {
                fatalError("CoreData error \(error), \(String(describing: error._userInfo))")
            }
        })
        return container
    }()
}
