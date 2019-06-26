//
//  StretchHeaderFlowLayout.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

//MARK: UICollectionViewLayoutAttributes
class StretchHeader: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect),
            let contentOffset = collectionView?.contentOffset else { return nil }

        for attribute in attributes {
            guard attribute.representedElementKind == UICollectionView.elementKindSectionHeader
                && attribute.indexPath.section == 0 else { continue }

            //Stretch Header base on collectionview contentOffset.y
            if contentOffset.y < 0 {    //scrolling up
                let offset = abs(contentOffset.y)
                let x = -offset * 0.5  //move left => Take half of offset
                let y = -offset        //move down
                let width = attribute.frame.width + offset      //add width
                let height = attribute.frame.height + offset    //add height
                
                attribute.frame = CGRect(x: x, y: y, width: width, height: height)
            }
        }
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
