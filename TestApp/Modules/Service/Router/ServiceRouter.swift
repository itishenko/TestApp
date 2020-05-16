//
//  ServiceRouter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ServiceRouter: ServiceRouterInput {

    weak var presenter: ServiceModuleInput!
    weak var viewController: UIViewController?
        
    func alert(with text: String) {
        let alertView = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Action.Ok".localized(), style: .default))
        viewController?.present(alertView, animated: true, completion: nil)
    }
}
