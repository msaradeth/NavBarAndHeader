//
//  MainCell.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    let padding = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .regular)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    func configure(title: String) {
        titleLabel.text = title        
    }
    
    
    func setupViews() {
        //setup contentView
        contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.fillSuperview(padding: padding)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        
        //calc cell height - contentView.systemLayoutSizeFitting
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

        //set cell height and width
        layoutAttributes.frame.size.height = size.height
        return layoutAttributes
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
