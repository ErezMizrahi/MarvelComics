//
//  ScrollViewController.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit

protocol ScrollViewControllerDelegate: class{
    var viewControllers: [UIViewController]? {get}
    var initalViewController: UIViewController? {get}
    func scrollViewDidScroll()
}

class ScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    
    weak var scrollDelegate: ScrollViewControllerDelegate?
    
    var pageSize: CGSize {
        return scrollView.frame.size
    }
    
    var viewControllers: [UIViewController?]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        scrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        viewControllers = scrollDelegate?.viewControllers
        print(viewControllers)
        for (index, controller) in viewControllers.enumerated() {
            if let controller = controller {
                addChild(controller)
                controller.view.frame = frame(for: index)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        print(scrollView.subviews)
        scrollView.contentSize = CGSize(width: pageSize.width * CGFloat(viewControllers.count),
                                        height: pageSize.height)
        
        if let controller = scrollDelegate?.initalViewController {
            setController(to: controller, animated: false)
        }
    }
    

    public func isControllerVisibale(_ controller: UIViewController?)-> Bool {
        guard controller != nil else {
           return false
        }
        
        for i in 0..<viewControllers.count {
            if viewControllers[i] == controller {
                let controllerFrame = frame(for: i)
                return controllerFrame.intersects(scrollView.bounds)
            }
        }
        return false
    }

}


private extension ScrollViewController {
    func frame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width,
                      y: 0,
                      width: pageSize.width,
                      height: pageSize.height)
    }
    
    func indexFor(controller: UIViewController?) -> Int? {
        return viewControllers.index(where: {$0 == controller } )
    }
}

extension ScrollViewController {
    public func setController(to controller: UIViewController, animated: Bool) {
        guard let index = indexFor(controller: controller) else { return }
        
        let contentOffset = CGPoint(x: pageSize.width * CGFloat(index), y: 0)
        scrollView.setContentOffset(contentOffset, animated: animated)
    }
}


extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll()
    }
}
