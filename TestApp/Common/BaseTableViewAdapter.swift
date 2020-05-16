//
//  BaseTableViewAdapter.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

public protocol BaseTableViewAdapterProtocol {
    var didSelectRowAt: ((IndexPath)->())? { get set }
}

open class BaseTableViewAdapter: NSObject, BaseTableViewAdapterProtocol {

    open weak var tableView: UITableView!
    public private(set) var descriptors = [SectionConfiguration]()
    
    public var didSelectRowAt: ((IndexPath)->())?

    public init(_ tableView: UITableView) {
        self.tableView = tableView
        super.init()

        tableView.delegate = self
        tableView.dataSource = self
    }

    public func reloadWith(descriptors: [SectionConfiguration]) {
        self.descriptors = descriptors
        tableView.reloadData()
    }
    
    public func reloadWithAnimation(indexPaths: [IndexPath]) {
        tableView.reloadRows(at: indexPaths, with: .automatic)
    }
 
    public func reloadCell(cellConfiguration: CellConfiguration) {
        guard let indexPath = indexPath(for: cellConfiguration) else {
            assertionFailure("cellConfiguration not found.")
            return
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    public func scrollTo(cellConfiguration: CellConfiguration, position: UITableView.ScrollPosition = .middle, animated: Bool = true) {
        guard let indexPath = indexPath(for: cellConfiguration) else { return }
        
        tableView.scrollToRow(at: indexPath, at: position, animated: animated)
    }
}

// MARK: - Editing

public extension BaseTableViewAdapter {
    
    func removeCell(cellConfiguration: CellConfiguration, animation: UITableView.RowAnimation = .automatic) {
        guard let indexPath = indexPath(for: cellConfiguration) else { return }
        
        self.removeCell(with: indexPath, animation: animation)
    }
    
    func removeCell(with indexPath: IndexPath, animation: UITableView.RowAnimation = .automatic) {
        guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count > indexPath.row else { return }
        
        let cell = descriptors[indexPath.section].rows[indexPath.row]
        descriptors[indexPath.section].remove(cell)
        
        tableView?.beginUpdates()
        tableView?.deleteRows(at: [indexPath], with: animation)
        tableView?.endUpdates()
    }
    
    func removeCells(with indexPaths: [IndexPath], animation: UITableView.RowAnimation = .automatic) {
        let sortedIndexPaths = indexPaths.sorted(by: { $0.compare($1) == .orderedDescending })
        
        tableView?.beginUpdates()
        for indexPath in sortedIndexPaths {
            guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count > indexPath.row else { continue }
            
            let cell = descriptors[indexPath.section].rows[indexPath.row]
            descriptors[indexPath.section].remove(cell)
            tableView?.deleteRows(at: [indexPath], with: animation)
        }
        tableView?.endUpdates()
    }
    
    func insertCell(with configuration: CellConfiguration, indexPath: IndexPath, animation: UITableView.RowAnimation = .automatic) {
        guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count >= indexPath.row else { return }
    
        descriptors[indexPath.section].insert(configuration, at: indexPath.row)
        
        tableView?.beginUpdates()
        tableView?.insertRows(at: [indexPath], with: animation)
        tableView?.endUpdates()
    }
    
    func insertCells(with items: [(configuration: CellConfiguration, indexPath: IndexPath)],
                     animation: UITableView.RowAnimation = .automatic) {
        tableView?.beginUpdates()
        for item in items {
            let indexPath = item.indexPath
            guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count >= indexPath.row else { continue }
            
            descriptors[indexPath.section].insert(item.configuration, at: indexPath.row)
            tableView?.insertRows(at: [indexPath], with: animation)
        }
        tableView?.endUpdates()
    }
    
    func insertCell(with configuration: CellConfiguration, after afterConfiguration: CellConfiguration, animation: UITableView.RowAnimation = .automatic) {
        guard let indexPath = indexPath(for: afterConfiguration) else { return }
        
        insertCell(with: configuration, indexPath: IndexPath(row: indexPath.row + 1, section: indexPath.section))
    }
    
    func replace(configuration: CellConfiguration, with newConfiguration: CellConfiguration, animation: UITableView.RowAnimation = .automatic) {
        guard let indexPath = indexPath(for: configuration) else { return }
        
        descriptors[indexPath.section].remove(configuration)
        descriptors[indexPath.section].insert(newConfiguration, at: indexPath.row)
        
        tableView?.beginUpdates()
        tableView?.reloadRows(at: [indexPath], with: animation)
        tableView?.endUpdates()
    }

    func insertSections(with sections: [(Int, SectionConfiguration)], animation: UITableView.RowAnimation = .automatic) {
        tableView?.beginUpdates()
        for (index, section) in sections {
            descriptors.insert(section, at: index)
            tableView?.insertSections(IndexSet(arrayLiteral: index), with: animation)
        }
        tableView?.endUpdates()
    }
}

public extension BaseTableViewAdapter {
    
    func indexPath(for cellConfiguration: CellConfiguration) -> IndexPath? {
        for (sectionIndex, section) in descriptors.enumerated() {
            for (cellIndex, configuration) in section.rows.enumerated() where configuration === cellConfiguration {
                return IndexPath(row: cellIndex, section: sectionIndex)
            }
        }
        return nil
    }
    
}

extension BaseTableViewAdapter: UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        return descriptors.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard descriptors.count > section else {
            return 0
        }
        return descriptors[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count > indexPath.row else {
            return UITableViewCell()
        }
        
        let descriptor = descriptors[indexPath.section].rows[indexPath.row]

        guard let cell = tableView.dequeueReusableCell(withIdentifier: descriptor.viewType.reuseIdentifier, for: indexPath) as? ConfigurableCell else {
            return UITableViewCell()
        }

        cell.configure(descriptor)

        return cell
    }
}

extension BaseTableViewAdapter: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard descriptors.count > indexPath.section, descriptors[indexPath.section].rows.count > indexPath.row else {
            return 0
        }
        return descriptors[indexPath.section].rows[indexPath.row].height
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerDescriptor = descriptors[section].header,
              let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerDescriptor.viewType.reuseIdentifier) as? ConfigurableHeaderFooterView else {
            return nil
        }

        header.configure(headerDescriptor)
        return header
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard descriptors.count > section, let headerDescriptor = descriptors[section].header else {
            return 0
        }
        return headerDescriptor.height
    }

    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerDescriptor = descriptors[section].footer,
              let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: footerDescriptor.viewType.reuseIdentifier) as? ConfigurableHeaderFooterView else {
            return nil
        }

        footer.configure(footerDescriptor)
        return footer
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard descriptors.count > section, let footerDescriptor = descriptors[section].footer else {
            return 0
        }
        return footerDescriptor.height
    }

    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
            
        guard descriptors.count > indexPath.section,
            descriptors[indexPath.section].rows.count > indexPath.row,
            let clickableCell = descriptors[indexPath.section].rows[indexPath.row] as? ClickableCellConfiguration else { return }
        
        clickableCell.onClicked?(indexPath)
    }
    
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard descriptors.count > indexPath.section,
            descriptors[indexPath.section].rows.count > indexPath.row,
            let swipeableCell = descriptors[indexPath.section].rows[indexPath.row] as? LeadingSwipeableCellConfiguration else { return nil }
        
        let style: UIContextualAction.Style = swipeableCell.rightAction == .delete ? .destructive : .normal
        let rightSwipeAction = UIContextualAction(style: style, title: swipeableCell.rightAction.title) { (action, view, handler) in
            swipeableCell.onSwipeRight?()
        }
        rightSwipeAction.backgroundColor = swipeableCell.rightAction.color
        let configuration = UISwipeActionsConfiguration(actions: [rightSwipeAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }

    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard descriptors.count > indexPath.section,
            descriptors[indexPath.section].rows.count > indexPath.row,
            let swipeableCell = descriptors[indexPath.section].rows[indexPath.row] as? TrailingSwipeableCellConfiguration else { return nil }
        
        let style: UIContextualAction.Style = swipeableCell.leftAction == .delete ? .destructive : .normal
        let leftSwipeAction = UIContextualAction(style: style, title: swipeableCell.leftAction.title) { (action, view, handler) in
            swipeableCell.onSwipeLeft?()
        }
        leftSwipeAction.backgroundColor = swipeableCell.leftAction.color
        let configuration = UISwipeActionsConfiguration(actions: [leftSwipeAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}
