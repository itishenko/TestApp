//
//  ItemRouter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ItemRouter: ItemRouterInput {
    
    weak var presenter: ItemModuleInput!
    weak var viewController: UIViewController?

    func alert(with text: String, handler: @escaping (Bool) -> Void) {
        let alertView = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Action.Yes".localized(), style: .default) { _ in
            handler(true)
        })
        alertView.addAction(UIAlertAction(title: "Action.No".localized(), style: .cancel) { _ in
            handler(false)
        })
        viewController?.present(alertView, animated: true, completion: nil)
    }
    
    func pop() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
