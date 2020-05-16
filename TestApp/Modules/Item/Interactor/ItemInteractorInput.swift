//
//  ItemInteractorInput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

protocol ItemInteractorInput {
    func update(item: Item)
    func insert(item: Item)
}
