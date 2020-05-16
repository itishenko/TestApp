//
//  MainModuleFactory.swift
//  TestApp
//
//  Created by Ivan Tischenko on 18/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

protocol MainModuleFactory {
    func buildMainModule() -> UIViewController
}

extension DependencyContainer: MainModuleFactory {

    func buildMainModule() -> UIViewController {

        let view = MainViewController()
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter(factory: self)

        view.output = presenter

        interactor.output = presenter
        presenter.interactor = interactor

        presenter.view = view
        presenter.router = router

        router.viewController = view
        router.presenter = presenter

        router.buildTabs()

        return view
    }
}
