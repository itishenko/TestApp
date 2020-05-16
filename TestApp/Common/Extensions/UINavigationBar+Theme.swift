//
//  UINavigationBar+Theme.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 taki. All rights reserved.
//

import UIKit

public extension UINavigationBar {
    
    func applyTheme(_ navigationTheme: NavigationTheme) {
        barTintColor = navigationTheme.barTintColor
        tintColor = navigationTheme.tintColor
    }
}

