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
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    lazy var detailLabel: UILabel = {
        let detailLabel = UILabel(frame: .zero)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.numberOfLines = 0
        return detailLabel
    }()
    var minCellHeight: CGFloat {
        return (superview?.bounds.height ?? 0) - (DetailHeader.defaultHeight + 70)  //need to stretch header
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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        
        contentView.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        detailLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)

        //calc cell height - add up all subviews height of contentView
        let cellHeight = contentView.subviews.reduce(0, {$0 + $1.bounds.height})
        
        //set cell height and width
        layoutAttributes.frame.size.height = max(cellHeight, minCellHeight)
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
