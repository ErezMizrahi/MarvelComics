//
//  visualLayoutConstants.swift
//  MarvelComics
//
//  Created by Erez Mizrahi on 12/10/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

struct VisualLayoutConstents {
    struct Cell {
        static let standerdCellHeight: CGFloat = 100
        static let feturedCellHeight: CGFloat = 300

    }
}

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    let dragOffset: CGFloat = 180
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var feturedItemIndex: Int {
        get{
        return max(0, Int(collectionView!.contentOffset.y / dragOffset))
        }
    }
    
    var nextItemPercentageOffset: CGFloat {
        get {
            return (collectionView!.contentOffset.y / dragOffset) - CGFloat(feturedItemIndex)
        }
    }
    
    var width: CGFloat {
        get {
            return collectionView?.bounds.width ?? 0
        }
    }
    
    var height: CGFloat {
        get {
            return collectionView?.bounds.height ?? 0
        }
    }
    
    var numberOfItems: Int {
        get {
            return collectionView?.numberOfItems(inSection: 0) ?? 0
        }
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            let contentHeight = (CGFloat(numberOfItems) * dragOffset) + (height - dragOffset)
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: true)
        
        let standerdHeight = VisualLayoutConstents.Cell.standerdCellHeight
        
        let feturedHeight = VisualLayoutConstents.Cell.feturedCellHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.zIndex = item
            
            var height = standerdHeight
        
            if indexPath.item == feturedItemIndex {
                
                let yOffset = standerdHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = feturedHeight
                
            } else if indexPath.item == (feturedItemIndex + 1) && indexPath.item != numberOfItems {
                
                let maxY = y + standerdHeight
                height = standerdHeight + max((feturedHeight - standerdHeight) * nextItemPercentageOffset, 0)
                
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attribute in cache {
            if attribute.frame.intersects(rect) {
                layoutAttributes.append(attribute)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
