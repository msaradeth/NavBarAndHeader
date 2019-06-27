//
//  SelfSizingCellNibfileVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit


class SelfSizingCellNibfileVC: UICollectionViewController, LoadImageService {
    var cellWidth: CGFloat {
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
        super.init(collectionViewLayout: self.flowLayout)
        title = "Self Sizing Cell"
        
        //setup views
        setupViews()
        
        //Load image if needed
        if let image = item.imageCache {
            item.imageCache = image
        }else {
            loadImage(imageUrl: item.imageUrl) { [weak self] (image) in
                self?.item.imageCache = image
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }                
            }
        }
        
    }
    
    func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "DetailCell2", bundle: nil), forCellWithReuseIdentifier: DetailCell2.cellIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.cellIdentifier)
    }
    
    
    //MARK: Header and Footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.cellIdentifier, for: indexPath) as! DetailHeader
        header.configure(item: item)
        return header
    }

    
    // MARK: rotation    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: 10)
        flowLayout.invalidateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK:  UICollectionViewDataSource
extension SelfSizingCellNibfileVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfItems.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        item.description = listOfItems[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell2.cellIdentifier, for: indexPath) as! DetailCell2
        cell.configure(item: item)
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension SelfSizingCellNibfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: DetailHeader.defaultHeight)
    }
    
}

