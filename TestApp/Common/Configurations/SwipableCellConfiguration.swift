//
//  SwipableCellConfiguration.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

public enum SwipeActionType {
    case delete
    case edit
    
    public var title: String {
        switch self {
        case .delete:
            return "Action.Delete".localized()
        case .edit:
            return "Action.Edit".localized()
        }
    }
    public var color: UIColor {
        switch self {
        case .delete:
            return .red
        case .edit:
            return .systemGreen
        }
    }    
}

public protocol TrailingSwipeableCellConfiguration where Self: CellConfiguration {

    var onSwipeLeft: (() -> Void)? { get set }
    var leftAction: SwipeActionType { get set }
}

public protocol LeadingSwipeableCellConfiguration where Self: CellConfiguration {

    var onSwipeRight: (() -> Void)? { get set }
    var rightAction: SwipeActionType { get set }
}
