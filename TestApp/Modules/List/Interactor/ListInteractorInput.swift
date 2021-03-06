//
//  ListInteractorInput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

protocol ListInteractorInput {
    func update(item: Item)
    func delete(item: Item)
    func loadStoredItems()
}
