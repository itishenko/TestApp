//
//  ItemModuleFactory.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

protocol ItemModuleFactory {
    func buildItemModule() -> (UIViewController, ItemModuleInput)
}

extension DependencyContainer: ItemModuleFactory {

    func buildItemModule() -> (UIViewController, ItemModuleInput) {

        let view = ItemViewController()
        let interactor = ItemInteractor(with: itemDataSource)
        let presenter = ItemPresenter()
        let router = ItemRouter()

        view.output = presenter

        interactor.output = presenter
        presenter.interactor = interactor

        presenter.view = view
        presenter.router = router

        router.viewController = view
        router.presenter = presenter

        return (view, presenter)
    }
}
