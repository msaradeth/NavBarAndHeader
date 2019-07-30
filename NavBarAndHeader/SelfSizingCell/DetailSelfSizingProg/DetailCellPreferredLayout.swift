//
//  DetailCell.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit


class DetailCellPreferredLayout: UICollectionViewCell {
    static let cellIdentifier = "DetailCellPreferredLayout"
    let padding = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    
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
    lazy var widthConstraint: NSLayoutConstraint = {
        let widthConstraint = contentView.widthAnchor.constraint(equalToConstant: contentView.bounds.width)
        widthConstraint.isActive = true
        return widthConstraint
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
    

//    MARK: systemLayoutSizeFitting - self sizing cell using contentView.systemLayoutSizeFitting
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        super.systemLayoutSizeFitting(targetSize)
        widthConstraint.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(targetSize)
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
//        widthConstraint.constant = bounds.size.width
//        return contentView.systemLayoutSizeFitting(targetSize)
//    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        detailLabel.text = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
