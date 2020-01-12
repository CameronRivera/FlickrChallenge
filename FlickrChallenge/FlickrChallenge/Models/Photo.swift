//
//  Photo.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PhotoWrapper: Codable{
    let photos: [Photo]
}

struct Photo: Codable{
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let description: DescriptionWrapper
    let url: String
    
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
