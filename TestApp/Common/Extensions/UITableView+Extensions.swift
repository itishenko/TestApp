//
//  UITableView+Extensions.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

public extension UITableView {
    
    func configure(_ configuration: CellConfiguration) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: configuration.viewType.reuseIdentifier) as? ConfigurableCell else {
            return UITableViewCell()
        }
        cell.configure(configuration)
        return cell
    }
    
    func configureHeaderFooterView(_ configuration: HeaderFooterViewConfiguration) -> UIView? {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: configuration.viewType.reuseIdentifier) as? ConfigurableHeaderFooterView else {
            return nil
        }
        view.configure(configuration)
        return view
    }
    
    func register<T: UITableViewCell>(_ cellType: T.Type) {
        let nib = ResourceRouter.nib(forType: cellType, nibName: cellType.reuseIdentifier)
        register(nib, forCellReuseIdentifier: cellType.reuseIdentifier)
    }
    
    func registerHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type) {
        let nib = ResourceRouter.nib(forType: viewType, nibName: viewType.reuseIdentifier)
        register(nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
    }
    
    func dequeueCell<T: UITableViewCell>(_ cellType: T.Type, forIndexPath indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as! T
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>(_ viewType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as! T
    }
}
