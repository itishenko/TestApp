//
//  ListModuleFactory.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

protocol ListModuleFactory {
    func buildListModule() -> UIViewController
}

extension DependencyContainer: ListModuleFactory {

    func buildListModule() -> UIViewController {

        let view = ListViewController()
        let interactor = ListInteractor(with: itemDataSource)
        let presenter = ListPresenter()
        let router = ListRouter(factory: self)

        view.output = presenter
        interactor.output = presenter
        presenter.interactor = interactor

        presenter.view = view
        presenter.router = router

        router.viewController = view
        router.presenter = presenter

        return view
    }
}
