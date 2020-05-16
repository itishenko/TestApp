//
//  ItemPresenter.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

class ItemPresenter: ItemModuleInput, ItemInteractorOutput {
    
    weak var view: ItemViewInput!
    var interactor: ItemInteractorInput!
    var router: ItemRouterInput!
        
    private var editItem: Item?
    
    func edit(item: Item) {
        editItem = item
    }
}

extension ItemPresenter: ItemViewOutput {
    func onRevert() {
        router.pop()
    }
    
    func onDone(with text: String) {
        
        if var item = editItem {
            item.title = text
            interactor.update(item: item)
        } else {
            interactor.insert(
                item: Item(uuid: UUID().uuidString, title: text, isSelected: false, createdAt: Date())
            )
        }
        router.pop()
    }
    
    func onBack(with text: String?) {
        
        if text.notEmpty, let text = text {
            router.alert(with: "Item.Alert.Save".localized()) { [weak self] save in
                if save {
                    self?.onDone(with: text)
                } else {
                    self?.router.pop()
                }
            }
        } else {
            router.pop()
        }
    }
    
    func viewIsReady() {
        let title = editItem == nil ? "Item.Add.Title" : "Item.Edit.Title"
        view.setupInitialState(with: title.localized(), text: editItem?.title)
    }
}
