//
//  MyCollectionView.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/26/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class MyCollectionView: UICollectionView {
    var item: EventModel
    var listOfItems: [String]
    
    init(listOfItems: [String], item: EventModel, flowLayout: UICollectionViewFlowLayout) {
        self.item = item
        self.listOfItems = listOfItems
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        setupViews()
    }
    
    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .white
        self.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.cellIdentifier)
        self.register(DetailCellDelegate.self, forCellWithReuseIdentifier: DetailCellDelegate.cellIdentifier)
    }
    
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.cellIdentifier, for: indexPath) as! DetailHeader
        header.configure(item: item)
        return header
    }
    
    func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionViewLayout.invalidateLayout()
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MyCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCellDelegate.cellIdentifier, for: indexPath) as! DetailCellDelegate
        item.description = listOfItems[indexPath.row]
        cell.configure(item: item)
        return cell
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension MyCollectionView: UICollectionViewDelegateFlowLayout {
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCellDelegate.cellIdentifier, for: indexPath) as! DetailCellDelegate
            
            //calc cell width and height
            let cellWidth = collectionView.bounds.width - 40
            let cellHeight = cell.getCellHeight(item: item, cellWidth: cellWidth)
            return CGSize(width: cellWidth, height: cellHeight)
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: DetailHeader.defaultHeight)
    }
    
}


