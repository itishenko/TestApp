//
//  NavigationTheme.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 taki. All rights reserved.
//

import Foundation
import UIKit

public enum NavigationTheme {
    case normal
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .normal: return .default
        }
    }
    
    var barTintColor: UIColor? {
        switch self {
        case .normal: return .white
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .normal: return .gray
        }
    }
}
