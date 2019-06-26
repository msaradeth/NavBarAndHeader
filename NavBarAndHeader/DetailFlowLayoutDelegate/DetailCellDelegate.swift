//
//  DetailCellDelegate.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/26/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class DetailCellDelegate: UICollectionViewCell {    
    static let cellIdentifier = "DetailCellDelegate"
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
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
        contentView.backgroundColor = UIColor.cyan
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        
        contentView.addSubview(detailLabel)
        detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding.top).isActive = true
        detailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        detailLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    func getCellHeight(item: EventModel, cellWidth: CGFloat) -> CGFloat {
        //update cell with data
        configure(item: item)
        layoutIfNeeded()
        
        //calc Height
        var cellHeight: CGFloat = padding.top
        contentView.subviews.forEach { (subview) in
            if subview is UILabel {
                if let label = subview as? UILabel {
                    cellHeight += label.text?.getHeight(constraintedWidth: cellWidth, font: label.font) ?? 0
                }
            }
        }
        return cellHeight
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



