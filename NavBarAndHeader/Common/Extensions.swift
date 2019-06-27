//
//  Extensions.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func fillSuperview(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) {
        guard let superview = self.superview else { return }
        topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom).isActive = true
    }
    
    func anchor(topView: UIView, leadingView: UIView, trailingView: UIView, bottomView: UIView, padding: UIEdgeInsets) {
        topAnchor.constraint(equalTo: topView.topAnchor, constant: padding.top).isActive = true
        
    }
}

extension UICollectionViewController {
    func navigationBarHeight() -> CGFloat {
        return self.navigationController?.navigationBar.bounds.height ?? 0
    }
}

extension String {
    func getHeight(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
}


extension UINavigationBar {
    func transparent() {
        setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        shadowImage = UIImage()
    }
    func visible() {
        setBackgroundImage(nil, for: .default)
        shadowImage = nil
    }
}

extension UISearchBar {
    static func setSearchBarAppearance() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .darkGray
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.white]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
    }
}

extension UICollectionViewFlowLayout {
    func availableHeight(collectionViewHeight: CGFloat, numberOfRows: CGFloat, navigationBarHeight: CGFloat) -> CGFloat {
        let availableHeight = collectionViewHeight
            - self.sectionInset.top - self.sectionInset.bottom
            - (self.minimumInteritemSpacing * numberOfRows)
            - navigationBarHeight
        return availableHeight
    }
    
    func availableWidth(collectionViewWidth: CGFloat, numberOfColumns: CGFloat) -> CGFloat {
        let availableWidth = collectionViewWidth
            - self.sectionInset.left - self.sectionInset.right
            - (self.minimumInteritemSpacing * numberOfColumns)
        return availableWidth
    }
}




