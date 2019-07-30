//
//  DetailVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

enum CellType: Int {
    case cellSelfsizingWithNibfile = 0
    case cellSelfsizingWithPreferredLayoutAttributesFitting = 1
    
    static func withValue(_ index: Int) -> CellType {
        switch index {
        case 0:
            return .cellSelfsizingWithNibfile
        case 1:
            return .cellSelfsizingWithPreferredLayoutAttributesFitting
        default:
            fatalError("not implemented yet")
        }
    }
}

class DetailVC: UICollectionViewController, LoadImageService {
    var cellWidth: CGFloat {
        let cellWidth = UIDevice.current.orientation == .portrait ?  collectionView.bounds.width : collectionView.bounds.width / 2.0
        return cellWidth - 10
    }

    var cellType: CellType {
        return CellType.withValue(curSegmentIndex)
    }
    
    //MARK: Handle segment selection
    var curSegmentIndex: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    var listOfItems: [String]
    var item: EventModel

    
    init(listOfItems: [String], event: EventModel, flowLayout: UICollectionViewFlowLayout, cellType: CellType) {
        self.listOfItems = listOfItems
        self.item = event
        self.curSegmentIndex = cellType.rawValue
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        super.init(collectionViewLayout: flowLayout)
        
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
    

    @objc func segmentSelected(sender: UISegmentedControl) {
        curSegmentIndex = sender.selectedSegmentIndex
    }
    
    func setupViews() {
        //CollectionView
        collectionView.backgroundColor = .white
        collectionView.register(DetailCellPreferredLayout.self, forCellWithReuseIdentifier: DetailCellPreferredLayout.cellIdentifier)
        collectionView.register(UINib(nibName: "DetailCell2", bundle: nil), forCellWithReuseIdentifier: DetailCell2.cellIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.cellIdentifier)
        
        //Segmented Control
        let segmentedControl = UISegmentedControl(items: ["NibFile+PreferredLayout", "PreferredLayoutAttribute"])
        segmentedControl.selectedSegmentIndex = cellType.rawValue
        segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    
    //MARK: header and footer
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.cellIdentifier, for: indexPath) as! DetailHeader
        header.configure(item: item)
        return header
    }
    
    
    //MARK: Handle Rotation
//    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.willTransition(to: newCollection, with: coordinator)
//        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: self.cellWidth, height: 100)
//            flowLayout.invalidateLayout()
//        }
//    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: self.cellWidth, height: 100)
            flowLayout.invalidateLayout()
        }
    }
  
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: UICollectionViewDatasource
extension DetailVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfItems.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        item.description = listOfItems[indexPath.row]
        
        switch cellType {
        case .cellSelfsizingWithNibfile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell2.cellIdentifier, for: indexPath) as! DetailCell2
            cell.configure(item: item)
            return cell
            
        case .cellSelfsizingWithPreferredLayoutAttributesFitting:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCellPreferredLayout.cellIdentifier, for: indexPath) as! DetailCellPreferredLayout
            cell.configure(item: item)
            return cell
        default:
            print("Not implemented here")
            return UICollectionViewCell()
        }
    }
}


extension DetailVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: DetailHeader.defaultHeight)
    }
    
}

