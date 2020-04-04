//
//  MarvelHeroesAPI.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Foundation

class MarvelHeroesAPI {
    
    static let shared = MarvelHeroesAPI()
    
    private let httpClient = HTTPClient()
    
    private init() {
    }
    
    func getHeroesBy(nameStartsWith: String, offset: Int, completionHandler: @escaping(HeroResponse) -> ()) {
        httpClient.getHeroes(nameStartsWith: nameStartsWith, offset: offset) { data in
            guard let data = data.data else { return }
            let jsonDecoder = JSONDecoder()
            guard let heroResponse = try? jsonDecoder.decode(HeroResponse.self, from: data) else { return }
            completionHandler(heroResponse)
        }
    }
    
    func getComicsBy(characterId: Int, offset: Int, completionHandler: @escaping(HeroComicsResponse) ->()) {
        httpClient.getComics(characterId: characterId, offset: offset) { data in
            guard let data = data.data else { return }
            let jsonDecoder = JSONDecoder()
            guard let heroComicsResponse = try? jsonDecoder.decode(HeroComicsResponse.self, from: data) else { return }
            completionHandler(heroComicsResponse)
        }
    }
    
    func getComicsBy(comicsTitle: String, offset: Int, completionHandler: @escaping(HeroComicsResponse) ->()) {
        httpClient.getComics(title: comicsTitle, offset: offset) { data in
            guard let data = data.data else { return }
            let jsonDecoder = JSONDecoder()
            guard let heroComicsResponse = try? jsonDecoder.decode(HeroComicsResponse.self, from: data) else { return }
            completionHandler(heroComicsResponse)
        }
    }
    
    func getComicsBy(comicsId: Int, completionHandler: @escaping(HeroComicsResponse) ->()) {
        httpClient.getComics(comicsId: comicsId) { data in
            guard let data = data.data else { return }
            let jsonDecoder = JSONDecoder()
            guard let heroComicsResponse = try? jsonDecoder.decode(HeroComicsResponse.self, from: data) else { return }
            completionHandler(heroComicsResponse)
        }
    }
    
    func getComicsBy(creatorId: Int, offset: Int, completionHandler: @escaping(HeroComicsResponse) ->()) {
        httpClient.getComics(creatorId: creatorId, offset: offset) { data in
            guard let data = data.data else { return }
            let jsonDecoder = JSONDecoder()
            guard let creatorComicsResponse = try? jsonDecoder.decode(HeroComicsResponse.self, from: data) else { return }
            completionHandler(creatorComicsResponse)
        }
    }
    
    func getCreatorsBy(name: String, offset: Int, completionHandler: @escaping(HeroComicsCreatorResponse) ->()) {
        httpClient.getCreators(name: name, offset: offset) { data in
            guard let data = data.data else { return }
            let jsonDecoder = JSONDecoder()
            guard let heroComicsResponse = try? jsonDecoder.decode(HeroComicsCreatorResponse.self, from: data) else { return }
            completionHandler(heroComicsResponse)
        }
    }
}
