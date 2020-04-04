//
//  HeroResponse.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct HeroResponse: Codable {
    var heroResponseData: HeroResponseData
    
    private enum CodingKeys: String, CodingKey {
        case heroResponseData = "data"
    }
}

struct HeroResponseData: Codable {
    let responseOffset: Int
    let responseLimit: Int
    let totalCount: Int
    var responseResults: [HeroResponseResult]
    
    private enum CodingKeys: String, CodingKey {
        case responseOffset = "offset"
        case responseLimit = "limit"
        case totalCount = "total"
        case responseResults = "results"
    }
}

struct HeroResponseResult: Codable {
    let heroId: Int
    let heroName: String
    let heroDescription: String
    let heroResourcePath: String
    let heroThumbnail: HeroThumbnail
    
    private enum CodingKeys: String, CodingKey {
        case heroId = "id"
        case heroName = "name"
        case heroDescription = "description"
        case heroResourcePath = "resourceURI"
        case heroThumbnail = "thumbnail"
    }
}

struct HeroThumbnail: Codable {
    let heroThumbnailPath: String
    let heroThumbnailFormat: String
    
    private enum CodingKeys: String, CodingKey {
        case heroThumbnailPath = "path"
        case heroThumbnailFormat = "extension"
    }
}
