//
//  SelfSizingCellNibfileVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit


class SelfSizingCellNibfileVC: UICollectionViewController {
    var flowLayout: UICollectionViewFlowLayout
    var listOfItems: [String]
    var item: EventModel
    
    
    init(listOfItems: [String], event: EventModel, flowLayout: UICollectionViewFlowLayout = StretchHeader()) {
        self.listOfItems = listOfItems
        self.item = event
        self.flowLayout = flowLayout
        self.flowLayout.scrollDirection = .vertical
        self.flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize //self cell sizing
        super.init(collectionViewLayout: self.flowLayout)
        setupViews()
    }
    
    
    func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "DetailCell2", bundle: nil), forCellWithReuseIdentifier: DetailCell2.cellIdentifier)
//        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.cellIdentifier)
    }
    
//    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.cellIdentifier, for: indexPath) as! DetailHeader
//        header.configure(item: item)
//        return header
//    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfItems.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        item.description = listOfItems[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell2.cellIdentifier, for: indexPath) as! DetailCell2
        cell.configure(item: item, cellWidth: collectionView.bounds.width-40)
        return cell
    }
    
    
    // MARK: rotation
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
//        layout.headerReferenceSize = .init(width: view.bounds.size.width, height: 30)
//        layout.invalidateLayout()
        
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.invalidateLayout()
//        collectionView.collectionViewLayout.invalidateLayout()
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    // MARK: layout - set estimated width to collection view width (minus content inset etc)
//    lazy var layout: UICollectionViewFlowLayout = {
//        let layout = EstimatedWidthCellsFlowLayout()
//        layout.headerReferenceSize = .init(width: view.bounds.size.width, height: 30)
//        layout.scrollDirection = .vertical
//        return layout
//    }()
//
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        collectionView.collectionViewLayout.invalidateLayout()
//    }
//
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension SelfSizingCellNibfileVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: DetailHeader.defaultHeight)
    }
    
}

