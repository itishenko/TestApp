//
//  CellConfiguration.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

public protocol ClickableCellConfiguration where Self: CellConfiguration {
    var onClicked: ((IndexPath) -> Void)? { get set }
}

public protocol CellConfiguration: AnyObject {
    var viewType: ConfigurableCell.Type { get }
    var height: CGFloat { get }
}

public extension CellConfiguration {
    var height: CGFloat { return UITableView.automaticDimension }
}

public protocol ConfigurableCell where Self: UITableViewCell {
    func configure(_ configuration: CellConfiguration)
}
