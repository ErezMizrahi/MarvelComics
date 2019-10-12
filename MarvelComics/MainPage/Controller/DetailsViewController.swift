//
//  DetailsViewController.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var coimcTitle: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    var details: Details?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageview.sd_setImage(with: details?.image)
        self.coimcTitle.text = details?.title
        self.desc.text = details?.desc
        
    }
    


}
