//
//  ItemViewInput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

protocol ItemViewInput: class {
    func setupInitialState(with navigationTitle: String, text: String?)
}
