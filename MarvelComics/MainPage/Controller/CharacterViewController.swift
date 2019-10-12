//
//  CharacterViewController.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    var controllerColor: UIColor = UIColor(red: 0.23, green: 0.66, blue: 0.96, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension CharacterViewController: ColoredView {}
