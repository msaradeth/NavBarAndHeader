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
    func fillSuperview() {
        guard let superview = self.superview else { return }
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
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



