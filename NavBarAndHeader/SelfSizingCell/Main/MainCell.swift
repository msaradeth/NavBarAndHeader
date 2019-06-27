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
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
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
        contentView.backgroundColor = .lightGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fillSuperview()
        
        contentView.addSubview(titleLabel)
        titleLabel.fillSuperview()
    }
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        //calc cell height - contentView.systemLayoutSizeFitting
//        layoutIfNeeded()
//        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//
//        //set cell height and width
//        layoutAttributes.frame.size.height = size.height
//        layoutAttributes.frame.size.width = (superview?.bounds.width ?? 0) - 40
//        return layoutAttributes
//    }
//
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        return super.systemLayoutSizeFitting(targetSize)
    }
    override func systemLayoutSizeFitting(
        _ targetSize: CGSize,
        withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority) -> CGSize {

        var contentSize = contentView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontalFittingPriority,
            verticalFittingPriority: verticalFittingPriority)

//        contentSize.width = targetSize.width
        contentSize.width = (superview?.bounds.width ?? 0) - 40

        return contentSize
    }
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
