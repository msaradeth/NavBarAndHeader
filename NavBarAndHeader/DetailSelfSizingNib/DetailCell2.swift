//
//  DetailCell2.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/26/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class DetailCell2: UICollectionViewCell {
    static let cellIdentifier = "Cell"
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    func configure(item: EventModel, cellWidth: CGFloat) {
        setupViews(cellWidth: cellWidth)        
        titleLabel.text = item.date
        detailLabel.text = item.description
    }
    
    func setupViews(cellWidth: CGFloat) {
        contentView.backgroundColor = .yellow
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        contentView.widthAnchor.constraint(equalToConstant: cellWidth).isActive = true
    }
}
