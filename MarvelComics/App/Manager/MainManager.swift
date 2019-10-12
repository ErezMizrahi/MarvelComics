//
//  MainManager.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import Moya


class MainManager {
    static let manager = MainManager()

    typealias callback = ([Comic]?, Error?)->Void
    
    private var service = MoyaProvider<MoyaNetworkService.ComicsService>()
    
     func apiCall(_ complition: @escaping callback) {
        service.request(.search(limit: "100")) { (result) in
            switch result {
            case .success(let response):
                print(try? JSONSerialization.jsonObject(with: response.data , options: .allowFragments))
                do {
                    let decoder = try JSONDecoder().decode(Result.self, from: response.data)
                    let mapedDecoder = decoder.data.results.filter{
                        !$0.thumbnail.extension.elementsEqual("http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available")}
                    complition(mapedDecoder,nil)
                }catch {
                    complition(nil, error)
                }
            case .failure(let error):
                complition(nil, error)
            }
        }
    }
  
}
