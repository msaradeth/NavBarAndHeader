//
//  DetailVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class DetailVC: UICollectionViewController {
    var item: EventModel
    
    init(event: EventModel, delegate: MasterViewModelDelegagte?, flowLayout: UICollectionViewFlowLayout) {
        self.item = event
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(collectionViewLayout: flowLayout)
        setupViews()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    

    func setupViews() {
        collectionView.backgroundColor = .white
//        collectionView.register(DetailCell.self, forCellWithReuseIdentifier: DetailCell.cellIdentifier)
        collectionView.register(UINib(nibName: "DetailCell2", bundle: nil), forCellWithReuseIdentifier: DetailCell2.cellIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.cellIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.cellIdentifier, for: indexPath) as! DetailHeader
        header.configure(item: item)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell2.cellIdentifier, for: indexPath) as! DetailCell2
        cell.configure(item: item)
        return cell
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension DetailVC: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell2.cellIdentifier, for: indexPath) as! DetailCell2
//
//        let minHeight = collectionView.frame.height - DetailHeader.defaultHeight - navigationBarHeight()
//        let estimatedCellHeight = event.date!.height(constraintedWidth: collectionView.frame.width, font: cell.titleLabel.font)
//                        + event.description.height(constraintedWidth: collectionView.frame.width, font: cell.detailLabel.font) + 40
////        let estimatedCellHeight = cell.cellHeight
//
//        let cellHeight = max(minHeight, cell.cellHeight)
////
////        print("FlowLayout: cellHeight width: \(cell.titleLabel.frame.size.height), height: \(cell.detailLabel.frame.size.height)  \(String(describing: cell.detailLabel.text))")
//           print("FlowLayout: estimatedCellHeight=\(estimatedCellHeight)   minHeight=\(minHeight)  titleLabel: \(cell.titleLabel.text), detailLabel: \(cell.detailLabel.text)) \n")
//
//        return CGSize(width: collectionView.frame.width, height: cellHeight)
//    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: DetailHeader.defaultHeight)
    }
    
}
