//
//  StretchHeaderFlowLayout.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

//MARK: UICollectionViewLayoutAttributes
class StretchHeaderFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect),
            let contentOffset = collectionView?.contentOffset else { return nil }
        
        for attribute in attributes {
            guard attribute.representedElementKind == UICollectionView.elementKindSectionHeader
                && attribute.indexPath.section == 0 else { continue }
            
            //Stretch Header base on collectionview contentOffset.y
            if contentOffset.y < 0 {    //scrolling up
                let offsetY = abs(contentOffset.y)
                let offsetX = offsetY * 0.5 //take percentage of OffsetY
                attribute.frame = CGRect(x: -offsetX, y: offsetY, width: contentOffset.y + (2*offsetX), height: contentOffset.y + (-offsetY))
            }
        }
        return attributes
    }
}
