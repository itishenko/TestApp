//
//  ItemViewController.swift
//  TestApp
//
//  Created by Ivan Tischenko on 17/05/2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var revertButton: UIButton!
    @IBOutlet private weak var doneButton: UIButton!
    
    var output: ItemViewOutput!

    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        output.viewIsReady()
    }
}

extension ItemViewController: ItemViewInput {
    
    func setupInitialState(with navigationTitle: String, text: String?) {
        title = navigationTitle
        textField.text = text
        doneButton.isEnabled = text.notEmpty
    }
}

private extension ItemViewController {
    
    func configureView() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: #imageLiteral(resourceName: "back"),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
        revertButton.setTitle("Action.Revert".localized(), for: .normal)
        doneButton.setTitle("Action.Done".localized(), for: .normal)
    }
    
    // MARK: Actions
    
    @objc func textFieldValueChanged() {
        doneButton.isEnabled = textField.text.notEmpty
    }
    
    @objc func backAction() {
        output.onBack(with: textField.text)
    }
    
    @IBAction func revertButtonTouched(_ sender: Any) {
        output.onRevert()
    }
    
    @IBAction func doneButtonTouched(_ sender: Any) {
        output.onDone(with: textField.text!)
    }
}

