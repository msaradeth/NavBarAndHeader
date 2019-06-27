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
        "The Movie",
    ]
    var cellWidth: CGFloat {
        return collectionView.bounds.width - 40
    }
    var flowLayout: UICollectionViewFlowLayout


    init(flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()) {
        self.flowLayout = flowLayout
        super.init(collectionViewLayout: flowLayout)
        self.title = "CollectionView"
        
        //Setup views
        setupViews()

        //Load Data
        items.append(contentsOf: listOfItems)
        let eventAPI = EventService()
        eventAPI.loadData { [weak self] (events) in
            self?.listOfEvents = events
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Collection View"
    }
    
    func setupViews() {
        flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: 100)
        collectionView.backgroundColor = .white
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: MainCell.reuseIdentifier)
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
        guard indexPath.row < listOfEvents.count else { return }
        let event = listOfEvents[indexPath.row]
        var items = listOfEvents.map{ $0.description }
        items.insert(event.description, at: 0)
        items.append(contentsOf: listOfItems)
        
        switch indexPath.row {
        case 0:
            fallthrough
        case 1:
            let vc = SelfSizingCellNibfileVC(listOfItems: items, event: event)
            navigationController?.pushViewController(vc, animated: true)
            
        case 2:
            title = ""
            let movieService = MovieService()
            let viewModel = MovieViewModel(movies: [], movieService: movieService)
            let vc = MovieVC(viewModel: viewModel, query: "Avenger")
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }

    
    //MARK: rotation
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        flowLayout.estimatedItemSize = CGSize(width: cellWidth, height: 100)
        flowLayout.invalidateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


