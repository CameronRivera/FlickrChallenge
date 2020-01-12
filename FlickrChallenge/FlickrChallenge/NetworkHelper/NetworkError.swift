//
//  NetworkError.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

enum NetworkError: Error{
    case badURL(String)
    case noData
    case decodingError(Error)
    case encodingError(Error)
    case networkClientError(Error)
    case noResponse
    case badStatusCode(Int)
}
