//
//  ItemRouterInput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

protocol ItemRouterInput {
    func alert(with text: String, handler: @escaping (Bool) -> Void)
    func pop()
}
