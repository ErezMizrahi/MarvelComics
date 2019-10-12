//
//  Results.swift
//  MarvelComics
//
//  Created by hackeru on 13/09/2019.
//  Copyright © 2019 erez8. All rights reserved.
//

import Foundation

struct Result: Codable {
    let code: Int
    let data: ComicDataContainer
}
    
    struct ComicDataContainer: Codable {
        let results: [Comic]
}

        struct Comic: Codable {
            let id: Int
            let digitalId: Int?
            let title: String
            let issueNumber: Double
            let variantDescription: String
            let description: String?
            let modified: String
            let isbn: String
            let upc: String
            let diamondCode: String
            let ean: String
            let issn: String
            let format: String
            let pageCount: Int
            let textObjects: [TextObject]
            let resourceURI: String
            let series: SeriesSummary
            let variants: [ComicSummary]
            let collections: [ComicSummary]
            let collectedIssues: [ComicSummary]
            let dates: [ComicDate]
            let prices: [ComicPrice]
            let thumbnail: Thumbnail
            let images: [Thumbnail]///
            let creators: CreatorList
            let characters: CharacterList
            let stories: StoryList
            let events: EventList
            
            struct TextObject: Codable {
                let type: String
                let language: String
                let text: String
            }
            struct SeriesSummary: Codable {
                let resourceURI: String
                let name: String
            }
            struct ComicSummary: Codable {
                let resourceURI: String
                let name: String
            }
            struct ComicDate: Codable {
                let type: String
                let date: String
            }
            struct ComicPrice: Codable {
                let type: String
                let price: Float
            }
            struct CreatorList: Codable {
                let available: Int
                let returned: Int
                let collectionURI: String
                let items: [CreatorSummary]
                
                struct CreatorSummary: Codable {
                    let resourceURI: String
                    let role: String
                    let name: String
                }
            }
            
            struct CharacterList: Codable {
                let available: Int
                let returned: Int
                let collectionURI: String
                let items: [CharacterSummary]
                
                struct CharacterSummary: Codable {
                    let resourceURI: String?
                    let role: String?
                    let name: String?
                }
            }
          
            struct StoryList: Codable {
                let available: Int
                let returned: Int
                let collectionURI: String
                let items: [StorySummary]
                
                struct StorySummary: Codable {
                    let resourceURI: String
                    let name: String
                    let type: String
                }
            }
         
            struct EventList: Codable {
                let available: Int
                let returned: Int
                let collectionURI: String
                let items: [EventSummary]
                
                struct EventSummary: Codable {
                    let resourceURI: String
                    let name: String
                }
            }
            
            struct Thumbnail: Codable {
                let path: String
                let `extension`: String
            }
        }
   
