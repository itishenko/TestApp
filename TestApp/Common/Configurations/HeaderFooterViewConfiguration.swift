//
//  HeaderFooterViewConfiguration.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

public protocol HeaderFooterViewConfiguration {
    var viewType: UITableViewHeaderFooterView.Type { get }
    var height: CGFloat { get }    
}

public extension HeaderFooterViewConfiguration {
    var height: CGFloat { return UITableView.automaticDimension }
}

public protocol ConfigurableHeaderFooterView where Self: UITableViewHeaderFooterView {
    func configure(_ configuration: HeaderFooterViewConfiguration)
}
