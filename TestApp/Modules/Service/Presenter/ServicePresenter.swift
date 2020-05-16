//
//  ServicePresenter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

class ServicePresenter: ServiceModuleInput, ServiceViewOutput, ServiceInteractorOutput {

    weak var view: ServiceViewInput!
    var interactor: ServiceInteractorInput!
    var router: ServiceRouterInput!

    func viewIsReady() {
        interactor.fetchData()
        view.beginLoading()
    }
    
    func update(with items: [CompactDisk]) {
        view.endLoading()
        let sections = items.map {
            BaseSectionConfiguration(
                rows: [
                    CDTableViewCellConfiguration(
                        price: "$ \($0.price)",
                        title: $0.title,
                        artist: $0.artist,
                        description: "\($0.company), \($0.country) (\($0.year))"
                    )
                ]
            )
        }
        view.update(with: sections)
    }
    
    func fetchFailured(with error: Error) {
        router.alert(with: error.localizedDescription)
    }
}
