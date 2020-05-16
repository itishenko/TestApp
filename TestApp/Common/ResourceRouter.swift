//
//  ResourceRouter.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

struct ResourceRouter {

    static func nib(forType anyClass: AnyClass, nibName: String? = nil) -> UINib {
        let nibName = nibName ?? String(describing: anyClass)
        return UINib(nibName: nibName, bundle: nil)
    }
}
