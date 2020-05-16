//
//  ListPresenter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 16/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

class ListPresenter: ListModuleInput, ListViewOutput, ListInteractorOutput {

    weak var view: ListViewInput!
    var interactor: ListInteractorInput!
    var router: ListRouterInput!
    
    func viewIsReady() {
        interactor.loadStoredItems()
    }
    
    func update(with items: [Item]) {
        let sections = items.map { item in
            BaseSectionConfiguration(
                rows: [
                    ItemTableViewCellConfiguration(
                        icon: item.isSelected ? #imageLiteral(resourceName: "checkmark") : #imageLiteral(resourceName: "target"),
                        title: item.title,
                        isChecked: item.isSelected,
                        onSwipeLeft: { [weak self] in
                            self?.interactor.delete(item: item)
                            self?.interactor.loadStoredItems()
                        },
                        onSwipeRight: { [weak self] in
                            self?.router.displayEditItem(with: item)
                        },
                        onClicked: { [weak self] indexPath in
                            self?.router.displayEditItem(with: item)
                        },
                        onValueChanged: { [weak self] value in
                            var editItem = item
                            editItem.isSelected = value
                            self?.interactor.update(item: editItem)
                            self?.interactor.loadStoredItems()
                        }
                    )
                ]
            )
        }
        view.update(with: sections)
    }
    
    func addNewItem() {
        router.dispayAddItem()
    }
}
