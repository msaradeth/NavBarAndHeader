//
//  MainVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/27/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

var listOfItems = ["An apple is a sweet, edible fruit produced by an apple tree.",
                   "An apricot is a fruit, or the tree that bears the fruit, of several species in the genus Prunus (stone fruits).",
                   "A banana is an edible fruit – botanically a berry – produced by several kinds of large herbaceous flowering plants in the genus Musa.",
                   "A grape is a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis.",
                   "Kiwifruit, or Chinese gooseberry is the edible berry of several species of woody vines in the genus Actinidia.",
                   "The orange is the fruit of the citrus species Citrus × sinensis in the family Rutaceae. ",
                   "A peach is a soft, juicy and fleshy stone fruit produced by a peach tree."]


class MainVC: UICollectionViewController {
    var listOfEvents: [EventModel] = []
    var items = [
        "SelfSizing Cell With Nibfile",
        "SelfSizing PreferredLayoutAttributesFitting",
        "SizeForItemAt indexPath",
    ]
    var cellWidth: CGFloat {
        return collectionView.bounds.width - 40
    }
    var flowLayout: UICollectionViewFlowLayout


    init(flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.flowLayout = flowLayout
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width-40, height: 100)
        super.init(collectionViewLayout: flowLayout)
        items.append(contentsOf: listOfItems)
        
        title = "CollectionView"
        collectionView.backgroundColor = .white
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
        
        let eventAPI = EventService()
        eventAPI.loadData { [weak self] (events) in
            self?.listOfEvents = events
//            print(self?.listOfEvents)
        }
        DispatchQueue.main.async {
//            self.collectionView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let flowLayout = collectionView.collectionViewLayout ? UICollectionViewFlowLayout {
//            flowLayout.
//        }
        // Register cell
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.reuseIdentifier, for: indexPath) as! MainCell
        // Configure the cell
        cell.configure(title: items[indexPath.row])
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let event = listOfEvents[indexPath.row]
        var listOfTexts = listOfItems
        listOfTexts.insert(event.description, at: 0)
        
        switch indexPath.row {
        case 0:
            let vc = SelfSizingCellNibfileVC(listOfItems: listOfTexts, event: event)
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
//        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.invalidateLayout()
    }

    
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        //        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
//        //        layout.headerReferenceSize = .init(width: view.bounds.size.width, height: 30)
//        //        layout.invalidateLayout()
//
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        flowLayout.invalidateLayout()
//        //        collectionView.collectionViewLayout.invalidateLayout()
//        super.traitCollectionDidChange(previousTraitCollection)
//    }
    
    // MARK: layout - set estimated width to collection view width (minus content inset etc)
    //    lazy var layout: UICollectionViewFlowLayout = {
    //        let layout = EstimatedWidthCellsFlowLayout()
    //        layout.headerReferenceSize = .init(width: view.bounds.size.width, height: 30)
    //        layout.scrollDirection = .vertical
    //        return layout
    //    }()
    //

    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
