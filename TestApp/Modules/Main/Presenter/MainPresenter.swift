//
//  MainPresenter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 18/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

class MainPresenter: MainModuleInput, MainViewOutput, MainInteractorOutput {

    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!

    func viewIsReady() {

    }
}
