//
//  ServiceInteractor.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

class ServiceInteractor<ItemsService>: ServiceInteractorInput where ItemsService: ItemsServiceProtocol,
                                                                    ItemsService.ItemType == CompactDisk {
    
    weak var output: ServiceInteractorOutput!
    private let catalogService: ItemsService

    init(with catalogService: ItemsService) {
        self.catalogService = catalogService
    }
    
    func fetchData() {
        catalogService.fetch { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.output.update(with: data)
                case .failure(let error):
                    self?.output.fetchFailured(with: error)
                }
            }
        }
    }
}
