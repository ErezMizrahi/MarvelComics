//
//  MoyaNetworking.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation
import Moya
import CommonCrypto

extension String {
    func md5() -> String {
        let data = Data(utf8) as NSData
        var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(data.bytes, CC_LONG(data.length), &hash)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}


let publicApiKey: String = "7de389cb4c8f13b5039bf81fc10b6aa4"
let privateApiKey: String = "1ba9bd13e386345daf1eed4f192bf4576695b58c"

enum MoyaNetworkService {
    enum ComicsService : TargetType {
        public var headers: [String : String]? {
            return ["Content-Type":"application/json"]
        }
        
        
        case search(limit: String)
        
        var baseURL: URL {
            return URL(string: "https://gateway.marvel.com")!
        }
        
        var path: String {
            switch self {
            case .search:
                return "/v1/public/comics"
            }
        }
        
        var method: Moya.Method{
            return .get
        }
        
        var sampleData: Data {
            return Data()
        }
        public var task: Task {
            let ts = "\(Date().timeIntervalSince1970)"
            
            let hash = (ts + privateApiKey + publicApiKey).md5()
            print(ts)
            print(hash)
            switch self{
            case .search(let limit):
                return .requestParameters(
                    parameters: [
                        "format":"hardcover",
                        "apikey":publicApiKey,
                        "ts": ts,
                        "hash": hash,
                        "limit":limit],
                    encoding: URLEncoding.queryString)
            }
        }
}
}


