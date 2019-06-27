//
//  DetailCell.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

enum CalcLayoutApproch {
    case sumOfSubviewSize
    case contentViewSystemLayoutSizeFitting
}

class DetailCellPreferredLayout: UICollectionViewCell {
    static let cellIdentifier = "DetailCellPreferredLayout"
    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    var calcLayoutApproch: CalcLayoutApproch = .contentViewSystemLayoutSizeFitting
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel(frame: .zero)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func configure(item: EventModel) {
        titleLabel.text = item.date
        detailLabel.text = item.description
    }
    
    private func setupViews() {
        contentView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding.left).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding.right).isActive = true
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        contentView.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding.top).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding.left).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding.right).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        if calcLayoutApproch == .contentViewSystemLayoutSizeFitting {
            return doPreferredLayoutAttributesFitting(layoutAttributes)
        }else {
            return sumOfSubviewSize(layoutAttributes)
        }
    }
    

    
    //MARK: Self Sizing Cell using contentViewSizeFiting
    func doPreferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //calc cell height - contentView.systemLayoutSizeFitting
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        //set cell height and width
        layoutAttributes.frame.size.height = size.height
        return layoutAttributes
    }
    
    
    func sumOfSubviewSize(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //calc cell height - add up all subviews height of contentView
        layoutIfNeeded()
        let cellHeight = contentView.subviews.reduce(padding.top, {$0 + $1.bounds.height})
        
        //set cell height and width
        layoutAttributes.frame.size.height = cellHeight
        layoutAttributes.frame.size.width  = (superview?.bounds.width ?? 0) - 40
        
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
