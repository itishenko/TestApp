//
//  ServiceInteractorOutput.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

protocol ServiceInteractorOutput: class {
    func update(with items: [CompactDisk])
    func fetchFailured(with error: Error)
}
