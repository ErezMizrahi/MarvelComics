//
//  ViewController.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {

    //test
    let provider = MoyaProvider<MoyaNetworkService.ComicsService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        provider.request(.search(limit: "10")) { (result) in
            print(result)
            switch result {
            case .success(let response):
//                print(try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments))
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: response.data)
                    print(decoder)
                }catch {
                    print(error.localizedDescription)

                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

