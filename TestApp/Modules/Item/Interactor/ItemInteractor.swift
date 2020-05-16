//
//  ItemInteractor.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

class ItemInteractor: ItemInteractorInput {

    weak var output: ItemInteractorOutput!
    
    private let dataSource: DataSource<Item>
    
    init(with dataSource: DataSource<Item>) {
        self.dataSource = dataSource
    }
    
    func update(item: Item) {
        try! dataSource.update(item: item)
    }
    
    func insert(item: Item) {
        try! dataSource.insert(item: item)
    }
}
