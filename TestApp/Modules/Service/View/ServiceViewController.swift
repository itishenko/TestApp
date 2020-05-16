//
//  ServiceViewController.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ServiceViewController: UITableViewController {

    var output: ServiceViewOutput!

    private lazy var adapter = BaseTableViewAdapter(tableView)
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        output.viewIsReady()
    }
}

extension ServiceViewController: ServiceViewInput {
    
    func update(with descriptors: [SectionConfiguration]) {
        adapter.reloadWith(descriptors: descriptors)
    }
    
    func beginLoading() {
        startActivityIndicator()
    }
    
    func endLoading() {
        stopActivityIndicator()
    }
}

private extension ServiceViewController {
    
    func configureView() {
        title = "Service.Navigation.Title".localized()
        tableView.apply(theme: .default)
        tableView.register(CDTableViewCell.self)
    }
}
