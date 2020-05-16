//
//  ServiceViewInput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

protocol ServiceViewInput: class {
    func update(with descriptors: [SectionConfiguration])
    func beginLoading()
    func endLoading()    
}
