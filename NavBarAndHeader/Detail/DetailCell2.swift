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
    
    func configure(item: EventModel) {
        titleLabel.text = item.date
        detailLabel.text = item.description
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
    }

}
