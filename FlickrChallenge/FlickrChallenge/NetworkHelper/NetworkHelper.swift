//
//  NetworkHelper.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/10/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

class NetworkHelper{
    static let shared = NetworkHelper()
    private let session = URLSession(configuration: .default)
    
    private init(){}
    
    func performDataTask(_ request: URLRequest, completion: @escaping (Result<Data,NetworkError>) -> ()){
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkClientError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                break
            default:
                completion(.failure(.badStatusCode(response.statusCode)))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            completion(.success(data))
        }
        dataTask.resume()
    }
}
