//
//  ViewController.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
   
    @IBOutlet weak var collectionview: UICollectionView!
    
    var arr = [Comic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.collectionViewLayout = CustomCollectionViewLayout()
       loadPage()
        
    }
   
    private func loadPage(){
        MainManager.manager.apiCall{[weak self] res, error in
            if let err = error {
                print(err)
            }
            
            guard let self = self, let result = res else { return }
            DispatchQueue.main.async {
                self.arr = result
                self.collectionview.delegate = self
                self.collectionview.dataSource = self
                self.collectionview.reloadData()
            }
            
        }
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as! ImageCell
        
        let thumbnail = arr[indexPath.row].thumbnail

        guard let url = URL(string: "\(thumbnail.path)/portrait_fantastic.\(thumbnail.extension)") else {
                return UICollectionViewCell()

        }
        cell.imageView.sd_setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 168*2, height: 225*2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsarr = arr[indexPath.row]
        print(URL(string: "\(detailsarr.thumbnail.path)/portrait_fantastic.\(detailsarr.thumbnail.extension)"))
        guard let url = URL(string: "\(detailsarr.thumbnail.path)/portrait_fantastic.\(detailsarr.thumbnail.extension)") else {
   
            return }
        let desc = detailsarr.description ?? "none"
        let details =  Details(image: url , title: detailsarr.title, desc: desc)
        performSegue(withIdentifier: "details", sender: details)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailsViewController
        destVC.details = sender as? Details
    }
    
}

struct Details {
    let image: URL
    let title: String
    let desc: String
}
