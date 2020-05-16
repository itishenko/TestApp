//
//  Optional+NotEmpty.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public extension Optional where Wrapped: Collection {
    
    var notEmpty: Bool {
        switch self {
        case .none:
            return false
            
        case .some(let collection):
            return !collection.isEmpty
        }
    }
}
