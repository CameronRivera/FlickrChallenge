//
//  FlickrPhotoAPI.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct FlickrPhotoAPI{
    static func getPhotos(_ urlString: String, completion: @escaping (Result<[Photo],NetworkError>) -> ()){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result {
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do{
                    let photographs = try JSONDecoder().decode(PhotoWrapper.self, from: data)
                    completion(.success(photographs.photos.photo))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getNameURL(_ query:String) -> String {
        let queryText = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "sunset"
        return "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Key.api_key)&text=\(queryText)&radius=32&extras=url_m,description&format=json&nojsoncallback=1"
    }
}
