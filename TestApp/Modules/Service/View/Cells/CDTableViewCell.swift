//
//  CDTableViewCell.swift
//  TestApp
//
//  Created by Ivan Tishchenko on 17.05.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

class CDTableViewCellConfiguration: CellConfiguration {
    public var viewType: ConfigurableCell.Type { CDTableViewCell.self }
    
    public let price: String
    public let title: String
    public let artist: String
    public let description: String
    
    public init(price: String, title: String, artist: String, description: String) {
        self.price = price
        self.title = title
        self.artist = artist
        self.description = description
    }
}

class CDTableViewCell: UITableViewCell, ConfigurableCell {
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        priceLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        artistLabel.font = UIFont.systemFont(ofSize: 12.0)
        descriptionLabel.font = UIFont.italicSystemFont(ofSize: 12)
    }
    
    func configure(_ configuration: CellConfiguration) {
        guard let configuration = configuration as? CDTableViewCellConfiguration else {
            return
        }
        priceLabel.text = configuration.price
        titleLabel.text = configuration.title
        artistLabel.text = configuration.artist
        descriptionLabel.text = configuration.description
    }
}
