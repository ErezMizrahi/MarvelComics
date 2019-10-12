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
    @IBOutlet weak var comicTitle: UILabel!
    
    var image: UIImage! {
        didSet {
                self.imageView.image = image
        }
    }
    
    override func awakeFromNib() {
        self.imageView.layer.cornerRadius = 20
        self.imageView.layer.masksToBounds = true
    }
    
    func populate(_ comic: Comic) {
        comicTitle.text = comic.title
    }
    
}
