//
//  ImageCell.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var coloredView: UIView!
    
    var image: UIImage! {
        didSet {
                self.imageView.image = image
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        let standerdHeight = VisualLayoutConstents.Cell.standerdCellHeight
        let feturedHeight = VisualLayoutConstents.Cell.feturedCellHeight
        
        let delta = 1 - ((feturedHeight - self.frame.height) / (feturedHeight - standerdHeight))
        
        let minAlpha: CGFloat = 0.3
        let maxAlpha: CGFloat = 0.75
    
        self.coloredView.alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
    }

    
}
