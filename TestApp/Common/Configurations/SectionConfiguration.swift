//
//  SectionConfiguration.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public protocol SectionConfiguration: AnyObject {
    var header: HeaderFooterViewConfiguration? { get }
    var footer: HeaderFooterViewConfiguration? { get }
    
    var rows: [CellConfiguration] { get }
    
    func add(_ cell: CellConfiguration)
    func remove(_ cell: CellConfiguration)
    func insert(_ cell: CellConfiguration, at index: Int)
}

public class BaseSectionConfiguration: SectionConfiguration {
    
    public var header: HeaderFooterViewConfiguration?
    public var footer: HeaderFooterViewConfiguration?
    
    public var rows: [CellConfiguration]
    
    public init(header: HeaderFooterViewConfiguration? = nil,
                footer: HeaderFooterViewConfiguration? = nil,
                rows: [CellConfiguration] = []) {
        self.header = header
        self.footer = footer
        self.rows = rows
    }
    
    public func add(_ cell: CellConfiguration) {
        rows.append(cell)
    }
    
    public func remove(_ cell: CellConfiguration) {
        guard let index = rows.firstIndex(where: { cell === $0 }) else { return }
        rows.remove(at: index)
    }
    
    public func insert(_ cell: CellConfiguration, at index: Int) {
        guard rows.count >= index else { return }
        rows.insert(cell, at: index)
    }
}
