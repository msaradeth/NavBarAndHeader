//
//  MasterVC.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class MasterVC: UIViewController {
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MasterCell.self, forCellWithReuseIdentifier: MasterCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        return collectionView
    }()
    var viewModel: MasterViewModel
    var flowLayout: UICollectionViewFlowLayout
    
    init(title: String, viewModel: MasterViewModel, flowLayout: UICollectionViewFlowLayout) {
        self.viewModel = viewModel
        self.flowLayout = flowLayout
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = title
        setupViews()
        
        viewModel.loadData {
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }
    }
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension MasterVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MasterCell.cellIdentifier, for: indexPath) as! MasterCell
        cell.configure(event: viewModel[indexPath], index: indexPath.row, delegate: viewModel)
        return cell
    }
}
extension MasterVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let flowLayout = UICollectionViewFlowLayout()
        let detailVC = DetailVC(event: viewModel[indexPath], delegate: viewModel, flowLayout: flowLayout)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: UICollectionViewDelegateFlowLayout
extension MasterVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        
        var numberOfColumns: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            numberOfColumns = UIDevice.current.userInterfaceIdiom == .phone ? 2 : 3
        }
        let availableWidth = collectionView.frame.width - flowlayout.sectionInset.left - flowlayout.sectionInset.right - (flowlayout.minimumInteritemSpacing*numberOfColumns)
        return CGSize(width: availableWidth/numberOfColumns, height: 250)
    }
}
