//
//  HeroCreatorResponse.swift
//  MarvelHeroes
//
//  Created by Alexander on 01.04.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

struct HeroComicsCreatorResponse: Codable {
    var heroComicsCreatorResponseData: HeroComicsCreatorResponseData
    
    private enum CodingKeys: String, CodingKey {
        case heroComicsCreatorResponseData = "data"
    }
}

struct HeroComicsCreatorResponseData: Codable {
    let totalCount: Int
    let currentCount: Int
    var results: [HeroComicsCreatorResponseResult]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total"
        case currentCount = "count"
        case results = "results"
    }
}

struct HeroComicsCreatorResponseResult: Codable {
    let heroComicsCreatorId: Int
    let heroComicsCreatorFirstName: String
    let heroComicsCreatorMiddleName: String
    let heroComicsCreatorLastName: String
    let heroComicsCreatorFullName: String
    let heroComicsCreatorThumbNail: HeroComicsCreatorThumbnail
    let heroComicsCreatorComicsResponse: HeroComicsCreatorComicsResponse
    
    private enum CodingKeys: String, CodingKey {
        case heroComicsCreatorId = "id"
        case heroComicsCreatorFirstName = "firstName"
        case heroComicsCreatorMiddleName = "middleName"
        case heroComicsCreatorLastName = "lastName"
        case heroComicsCreatorFullName = "fullName"
        case heroComicsCreatorThumbNail = "thumbnail"
        case heroComicsCreatorComicsResponse = "comics"
    }
}

struct HeroComicsCreatorThumbnail: Codable {
    let heroComicsCreatorThumbnailPath: String
    let heroComicsCreatorThumbnailExtension: String
    
    private enum CodingKeys: String, CodingKey {
        case heroComicsCreatorThumbnailPath = "path"
        case heroComicsCreatorThumbnailExtension = "extension"
    }
}

struct HeroComicsCreatorComicsResponse: Codable {
    let heroComicsCreatorComicsData: [HeroComicsCreatorData]
    let heroComicsCreatorAvailable: Int
    
    private enum CodingKeys: String, CodingKey {
        case heroComicsCreatorComicsData = "items"
        case heroComicsCreatorAvailable = "available"
    }
}

struct HeroComicsCreatorData: Codable {
    let heroComicsCreatorName: String
    let heroComicsCreatorComicsPath: String
    
    private enum CodingKeys: String, CodingKey {
        case heroComicsCreatorComicsPath = "resourceURI"
        case heroComicsCreatorName = "name"
    }
}
