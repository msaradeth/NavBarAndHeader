//
//  LayoutDelegateVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class LayoutDelegateVC: UIViewController {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    fileprivate var availableWidth: CGFloat {
        return collectionView.bounds.width - 40
    }
    var flowLayout: UICollectionViewFlowLayout
    var listOfItems: [String]
    var item: EventModel
    
    
    //MARK: init and setup ViewController
    init(listOfItems: [String], event: EventModel, flowLayout: UICollectionViewFlowLayout = StretchHeader()) {
        self.listOfItems = listOfItems
        self.item = event
        self.flowLayout = flowLayout
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
