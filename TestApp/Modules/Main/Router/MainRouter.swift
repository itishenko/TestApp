//
//  MainRouter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 18/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class MainRouter: MainRouterInput {
    typealias MainRouterFactory = ListModuleFactory & ServiceModuleFactory

    weak var presenter: MainModuleInput!
    weak var viewController: UIViewController?

    var factory: MainRouterFactory

    init(factory: MainRouterFactory) {
        self.factory = factory
    }

    func buildTabs() {
        guard let tabBarVC = viewController as? UITabBarController else {
            return
        }
        tabBarVC.viewControllers = [
            listVC,
            serviceVC
        ].map { NavigationController(rootViewController: $0) }
    }

    var listVC: UIViewController {
        let vc = factory.buildListModule()
        vc.tabBarItem = UITabBarItem(
            title: "List.Tab.Title".localized(),
            image: #imageLiteral(resourceName: "swords"),
            tag: 0
        )
        return vc
    }

    var serviceVC: UIViewController {
        let vc = factory.buildServiceModule()
        vc.tabBarItem = UITabBarItem(
            title: "Service.Tab.Title".localized(),
            image: #imageLiteral(resourceName: "bank"),
            tag: 0
        )
        return vc
    }
}
