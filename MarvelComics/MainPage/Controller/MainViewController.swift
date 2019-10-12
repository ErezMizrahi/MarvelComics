//
//  MainViewController.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

protocol ColoredView {
    var controllerColor: UIColor {get}
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var maskCornerView: UIView!
    @IBOutlet weak var colorView: UIView!
    lazy var comicController: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "ComicsViewController")
    }()
    lazy var characterController: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "CharacterViewController")
    }()
    lazy var eventController: UIViewController! = {
        return self.storyboard?.instantiateViewController(withIdentifier: "EventViewController")
    }()
    
    var scrollViewController : ScrollViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        maskCornerView.layer.cornerRadius = 10
        maskCornerView.layer.masksToBounds = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let destvc = segue.destination as! ScrollViewController
            scrollViewController = destvc
            destvc.scrollDelegate = self
    }
    
    @IBAction func showComics(_ sender: Any) {
        print(#function)
        scrollViewController.setController(to: comicController, animated: true)
    }
    
    @IBAction func showCharacters(_ sender: Any) {
        print(#function)
        scrollViewController.setController(to: characterController, animated: true)

    }
    
    @IBAction func showEvents(_ sender: Any) {
        print(#function)
        scrollViewController.setController(to: eventController, animated: true)

    }
    

}


extension MainViewController: ScrollViewControllerDelegate{
    var viewControllers: [UIViewController]? {
        return [characterController,comicController,eventController]
    }
    
    var initalViewController: UIViewController? {
        return comicController
    }
    
    func scrollViewDidScroll() {
        let min: CGFloat = 0
        let max: CGFloat = scrollViewController.pageSize.width
        let x = scrollViewController.scrollView.contentOffset.x
        
        let result = ((x - min) / (max - min)) - 1
        let offset = abs(result)
        
        let controller: UIViewController?
        if scrollViewController.isControllerVisibale(characterController){
            controller = characterController
            if let controller = controller as? ColoredView {
                colorView.backgroundColor = controller.controllerColor
                colorView.alpha = offset
            }
            
        } else if scrollViewController.isControllerVisibale(eventController) {
            controller = eventController
            if let controller = controller as? ColoredView {
                colorView.backgroundColor = controller.controllerColor
                colorView.alpha = offset
            }
        }
    }
    
}
