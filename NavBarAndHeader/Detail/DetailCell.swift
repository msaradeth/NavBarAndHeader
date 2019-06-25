//
//  DetailCell.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class DetailCell: UICollectionViewCell {
    static let cellIdentifier = "Cell"
    let padding: CGFloat = 0
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
//        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel(frame: .zero)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    var cellHeight: CGFloat {
        return titleLabel.frame.size.height + detailLabel.frame.size.height + 16
    }
    var cellMinHeight: CGFloat {
        return (superview?.bounds.height ?? 0) - (DetailHeader.defaultHeight + 50)  //navbar + etc. height = 50
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func configure(item: EventModel) {
        titleLabel.text = item.date
        detailLabel.text = item.description
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        detailLabel.setContentHuggingPriority(.defaultLow, for: .vertical) 
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        guard let superview = superview else { return layoutAttributes}        
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        print(size.width, superview.bounds.width)
        
        layoutAttributes.frame.size.width  = superview.bounds.width - 40
        layoutAttributes.frame.size.height = max(cellMinHeight, cellHeight)
        return layoutAttributes
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        detailLabel.text = nil
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
