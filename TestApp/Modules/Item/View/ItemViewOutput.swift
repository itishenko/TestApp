//
//  ItemViewOutput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

protocol ItemViewOutput {

    func viewIsReady()
    func onRevert()
    func onDone(with text: String)
    func onBack(with text: String?)
}
