//
//  ListRouter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ListRouter: ListRouterInput {

    weak var presenter: ListModuleInput!
    weak var viewController: UIViewController?
    var factory: ItemModuleFactory

    init(factory: ItemModuleFactory) {
        self.factory = factory
    }

    func dispayAddItem() {
        let (itemVC, _) = factory.buildItemModule()
        viewController?.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    func displayEditItem(with item: Item) {
        let (itemVC, itemModuleInput) = factory.buildItemModule()
        itemModuleInput.edit(item: item)
        viewController?.navigationController?.pushViewController(itemVC, animated: true)
    }
}
