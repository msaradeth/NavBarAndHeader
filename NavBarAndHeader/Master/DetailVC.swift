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
    case cellSizingWithSizeForItemAtDelegate = 2
    
    static func withValue(_ index: Int) -> CellType {
        switch index {
        case 0:
            return .cellSelfsizingWithNibfile
        case 1:
            return .cellSelfsizingWithPreferredLayoutAttributesFitting
        case 2:
            return .cellSizingWithSizeForItemAtDelegate
        default:
            fatalError("not implemented yet")
        }
    }
}

class DetailVC: UICollectionViewController {
    lazy var customCollectionView: MyCollectionView = {
        let customCollectionView = MyCollectionView(listOfItems: self.listOfItems, item: self.item, flowLayout: StretchHeader())
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return customCollectionView
    }()
    var flowLayout: UICollectionViewFlowLayout
    var cellType: CellType {
        return CellType.withValue(curSegmentIndex)
    }
    var curSegmentIndex: Int = 0 {
        didSet {
            if cellType == .cellSelfsizingWithNibfile || cellType == .cellSelfsizingWithPreferredLayoutAttributesFitting {
                if customCollectionView.superview != nil {
                    customCollectionView.removeFromSuperview()
                }
                collectionView.reloadData()
                
            }else if cellType == .cellSizingWithSizeForItemAtDelegate {
                view.addSubview(customCollectionView)
                customCollectionView.fillSuperview()
            }
        }
    }
    var listOfItems: [String]
    var item: EventModel

    
    init(listOfItems: [String], event: EventModel, delegate: MasterViewModelDelegagte?, flowLayout: UICollectionViewFlowLayout, cellType: CellType) {
        self.listOfItems = listOfItems
        self.item = event
        self.flowLayout = flowLayout
        self.curSegmentIndex = cellType.rawValue
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize //self cell sizing
        super.init(collectionViewLayout: flowLayout)
        setupViews()
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc func segmentSelected(sender: UISegmentedControl) {
        curSegmentIndex = sender.selectedSegmentIndex
    }
    
    func setupViews() {
        collectionView.backgroundColor = .white
        collectionView.register(DetailCellPreferredLayout.self, forCellWithReuseIdentifier: DetailCellPreferredLayout.cellIdentifier)
        collectionView.register(UINib(nibName: "DetailCell2", bundle: nil), forCellWithReuseIdentifier: DetailCell2.cellIdentifier)
        collectionView.register(DetailHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailHeader.cellIdentifier)
        
        let segmentedControl = UISegmentedControl(items: ["NibFile", "PreferredLayout", "SizeForItemAt"])
        segmentedControl.selectedSegmentIndex = cellType.rawValue
        segmentedControl.addTarget(self, action: #selector(segmentSelected(sender:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailHeader.cellIdentifier, for: indexPath) as! DetailHeader
        header.configure(item: item)
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfItems.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        item.description = listOfItems[indexPath.row]
        
        switch cellType {
        case .cellSelfsizingWithNibfile:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCell2.cellIdentifier, for: indexPath) as! DetailCell2
            cell.configure(item: item, cellWidth: collectionView.bounds.width-40)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: DetailHeader.defaultHeight)
    }
    
}

