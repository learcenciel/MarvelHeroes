//
//  HTTPClient.swift
//  MarvelHeroes
//
//  Created by Alexander on 29.03.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Alamofire
import CommonCrypto
import Foundation

class HTTPClient {
    
    var request: Request?
    
    static let publicKey = "9f56fbd346ec2141207198a9cd9b7b2d"
    static let privateKey = "573ac509eab875b5d8f9b5d85f7eb88b90c733fd"
    
    func getHeroes(nameStartsWith: String, offset: Int, completionHandler: @escaping((AFDataResponse<Data>) -> ())) {
        let url = "https://gateway.marvel.com:443/v1/public/characters"
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let hash = Crypto.MD5(String(timestamp)+HTTPClient.privateKey+HTTPClient.publicKey) else { return }
        
        let parameters: Parameters = [
            "nameStartsWith": nameStartsWith,
            "offset": offset,
            "limit": "8",
            "ts": timestamp,
            "apikey": HTTPClient.publicKey,
            "hash": hash
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData(completionHandler: completionHandler)    }
    
    func getComics(characterId: Int, offset: Int, completionHandler: @escaping((AFDataResponse<Data>) -> ())) {
        let url = "https://gateway.marvel.com:443/v1/public/characters/\(characterId)/comics"
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let hash = Crypto.MD5(String(timestamp)+HTTPClient.privateKey+HTTPClient.publicKey) else { return }
        
        let parameters: Parameters = [
            "offset": offset,
            "limit": "8",
            "ts": timestamp,
            "apikey": HTTPClient.publicKey,
            "hash": hash
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData(completionHandler: completionHandler)
    }
    
    func getComics(creatorId: Int, offset: Int, completionHandler: @escaping((AFDataResponse<Data>) -> ())) {
        let url = "https://gateway.marvel.com:443/v1/public/creators/\(creatorId)/comics"
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let hash = Crypto.MD5(String(timestamp)+HTTPClient.privateKey+HTTPClient.publicKey) else { return }
        
        let parameters: Parameters = [
            "offset": offset,
            "limit": "8",
            "ts": timestamp,
            "apikey": HTTPClient.publicKey,
            "hash": hash
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData(completionHandler: completionHandler)
    }
    
    func getComics(title: String, offset: Int, completionHandler: @escaping((AFDataResponse<Data>) -> ())) {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let hash = Crypto.MD5(String(timestamp)+HTTPClient.privateKey+HTTPClient.publicKey) else { return }
        let url = "https://gateway.marvel.com:443/v1/public/comics"
        
        let parameters: Parameters = [
            "offset": offset,
            "limit": "8",
            "title": title,
            "ts": timestamp,
            "apikey": HTTPClient.publicKey,
            "hash": hash
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData(completionHandler: completionHandler)
    }
    
    func getComics(comicsId: Int, completionHandler: @escaping((AFDataResponse<Data>) -> ())) {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let hash = Crypto.MD5(String(timestamp)+HTTPClient.privateKey+HTTPClient.publicKey) else { return }
        let url = "https://gateway.marvel.com:443/v1/public/comics/\(comicsId)"
        
        let parameters: Parameters = [
            "ts": timestamp,
            "apikey": HTTPClient.publicKey,
            "hash": hash
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData(completionHandler: completionHandler)
    }
    
    func getCreators(name: String, offset: Int, completionHandler: @escaping((AFDataResponse<Data>) -> ())) {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        guard let hash = Crypto.MD5(String(timestamp)+HTTPClient.privateKey+HTTPClient.publicKey) else { return }
        let url = "https://gateway.marvel.com:443/v1/public/creators"
        
        let parameters: Parameters = [
            "offset": offset,
            "limit": "8",
            "nameStartsWith": name,
            "ts": timestamp,
            "apikey": HTTPClient.publicKey,
            "hash": hash
        ]
        AF.request(url,
                   method: .get,
                   parameters: parameters).responseData(completionHandler: completionHandler)
    }
}

class Crypto {
    static func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
