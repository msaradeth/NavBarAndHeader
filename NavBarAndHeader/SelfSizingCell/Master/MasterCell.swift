//
//  MasterCell.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class MasterCell: UICollectionViewCell {
    static let cellIdentifier = "cell"
    lazy var imageView: UIImageView = {
        let placeholder = UIImage(named: "placeholder")
        let imageView = UIImageView(image: placeholder)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = ContentMode.scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    func configure(event: EventModel, index: Int, delegate: MasterViewModelDelegagte?) {
        if let image = event.imageCache {
            imageView.image = image
        }else {
            imageView.image = #imageLiteral(resourceName: "placeholder")
            delegate?.loadImage(index: index, completion: { [weak self] (image) in
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
            })
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
