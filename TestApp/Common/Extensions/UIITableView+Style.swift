//
//  UIITableView+Style.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    enum Theme {
        case `default`
    }
    
    func apply(theme: Theme) {
        switch theme {
        case .default:
            backgroundColor = .white
            separatorColor = .clear
            separatorStyle = .none
            rowHeight = UITableView.automaticDimension
            sectionHeaderHeight = UITableView.automaticDimension
            sectionFooterHeight = UITableView.automaticDimension
            
            tableFooterView = UIView()
        }
    }
}
