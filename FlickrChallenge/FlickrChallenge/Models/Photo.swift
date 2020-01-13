//
//  Photo.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable{
    let photos: MetaData
}

struct MetaData: Codable{
    let photo: [Photo]
}

struct Photo: Codable, Equatable{
    
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let description: DescriptionWrapper
    let url: String?
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        if lhs.id == rhs.id{
            return true
        } else {
            return false
        }
    }
    
    enum CodingKeys: String, CodingKey{
        case id = "id"
        case owner = "owner"
        case secret = "secret"
        case server = "server"
        case farm = "farm"
        case title = "title"
        case description = "description"
        case url = "url_m"
    }
}

struct DescriptionWrapper: Codable{
    let content: String
    
    enum CodingKeys: String, CodingKey{
        case content = "_content"
    }
}
