//
//  HeroComicsResponse.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct HeroComicsResponse: Codable {
    var heroComicsResponseData: HeroComicsResponseData
    
    private enum CodingKeys: String, CodingKey {
        case heroComicsResponseData = "data"
    }
}

struct HeroComicsResponseData: Codable {
    let totalCount: Int
    let currentCount: Int
    var results: [HeroComicsResponseResult]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total"
        case currentCount = "count"
        case results = "results"
    }
}

struct HeroComicsResponseResult: Codable {
    let comicsId: Int
    let comicsTitle: String
    let comicsThumbNail: HeroComicsThumbnail
    var comicsCreatorsResponse: HeroComicsCreators
    let comicsDescriptionResponse: [HeroComicsDescription]
    
    private enum CodingKeys: String, CodingKey {
        case comicsId = "id"
        case comicsTitle = "title"
        case comicsThumbNail = "thumbnail"
        case comicsCreatorsResponse = "creators"
        case comicsDescriptionResponse = "textObjects"
    }
}

struct HeroComicsDescription: Codable {
    let comicsDescriptionText: String
    
    private enum CodingKeys: String, CodingKey {
        case comicsDescriptionText = "text"
    }
}


struct HeroComicsThumbnail: Codable {
    let comicsThumbnailPath: String
    let comicsThumbnailExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case comicsThumbnailPath = "path"
        case comicsThumbnailExtension = "extension"
    }
}

struct HeroComicsCreators: Codable {
    let comicsCreatorsAvailable: Int
    var comicsCreators: [HeroComicsCreator]
    
    private enum CodingKeys: String, CodingKey {
        case comicsCreatorsAvailable = "available"
        case comicsCreators = "items"
    }
}

struct HeroComicsCreator: Codable {
    let comicsCreatorName: String
    let comicsCreatorRole: String
    
    private enum CodingKeys: String, CodingKey {
        case comicsCreatorName = "name"
        case comicsCreatorRole = "role"
    }
}
