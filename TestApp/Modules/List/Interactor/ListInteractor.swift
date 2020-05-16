//
//  ListInteractor.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

class ListInteractor: ListInteractorInput {

    weak var output: ListInteractorOutput!
    
    private let dataSource: DataSource<Item>
    
    init(with dataSource: DataSource<Item>) {
        self.dataSource = dataSource
    }
    
    func loadStoredItems() {
        let items: [Item] = try! dataSource.getAll()
        output.update(with: items)
    }
    
    func delete(item: Item) {
        try! dataSource.delete(item: item)
    }
    
    func update(item: Item) {
        try! dataSource.update(item: item)
    }
}
