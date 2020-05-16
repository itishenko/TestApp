//
//  ItemTableViewCell.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 16.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class ItemTableViewCellConfiguration: CellConfiguration, ClickableCellConfiguration, TrailingSwipeableCellConfiguration, LeadingSwipeableCellConfiguration {
    
    var onSwipeLeft: (() -> Void)?
    var leftAction: SwipeActionType = .delete
    
    var onSwipeRight: (() -> Void)?
    var rightAction: SwipeActionType = .edit
        
    public var viewType: ConfigurableCell.Type { ItemTableViewCell.self }
    public let icon: UIImage?
    public let title: String
    public var isChecked: Bool
    public var onClicked: ((IndexPath) -> Void)?
    public var onValueChanged: ((_ state: Bool) -> Void)?
    
    init(icon: UIImage?,
         title: String,
         isChecked: Bool,
         onSwipeLeft: (() -> Void)? = nil,
         onSwipeRight: (() -> Void)? = nil,
         onClicked: ((IndexPath) -> Void)? = nil,
         onValueChanged: ((Bool) -> Void)? = nil) {
        self.icon = icon
        self.title = title
        self.isChecked = isChecked
        self.onSwipeLeft = onSwipeLeft
        self.onSwipeRight = onSwipeRight
        self.onClicked = onClicked
        self.onValueChanged = onValueChanged
    }
}


class ItemTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var switchView: UISwitch!
    @IBOutlet private var titleLabel: UILabel!
    
    private var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                iconImageView.image = #imageLiteral(resourceName: "checkmark")
            } else {
                iconImageView.image = #imageLiteral(resourceName: "target")
            }
        }
    }
    private var onValueChanged: ((_ state: Bool) -> Void)?
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        titleLabel.font = UIFont.systemFont(ofSize: 14.0)
    }
    
    public func configure(_ configuration: CellConfiguration) {
        guard let configuration = configuration as? ItemTableViewCellConfiguration else { return }
        iconImageView.image = configuration.icon
        titleLabel.text = configuration.title
        isChecked = configuration.isChecked
        switchView.isOn = configuration.isChecked
        onValueChanged = configuration.onValueChanged
    }
    
    @IBAction func onSwitchValueChanged(_ sender: Any) {
        isChecked = !isChecked
        onValueChanged?(isChecked)
    }
}

