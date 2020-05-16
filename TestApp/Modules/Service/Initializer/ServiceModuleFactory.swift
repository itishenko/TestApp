//
//  ServiceModuleFactory.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

protocol ServiceModuleFactory {
    func buildServiceModule() -> UIViewController
}

extension DependencyContainer: ServiceModuleFactory {

    func buildServiceModule() -> UIViewController {

        let view = ServiceViewController()
        let interactor = ServiceInteractor(with: diskCatalogService)
        let presenter = ServicePresenter()
        let router = ServiceRouter()

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
