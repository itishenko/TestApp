//
//  ListViewController.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var output: ListViewOutput!

    private lazy var adapter = BaseTableViewAdapter(tableView)

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        output.viewIsReady()
    }
}

// MARK: ListViewInput

extension ListViewController: ListViewInput {
    
    func update(with descriptors: [SectionConfiguration]) {
        adapter.reloadWith(descriptors: descriptors)
    }
}

private extension ListViewController {
    
    func configureView() {
        title = "List.Navigation.Title".localized()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "plus"),
            style: .plain,
            target: self,
            action: #selector(onPlusButtonClicked)
        )
        
        tableView.apply(theme: .default)
        tableView.register(ItemTableViewCell.self)
    }
    
    @objc func onPlusButtonClicked() {
        output.addNewItem()
    }
}
