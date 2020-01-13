//
//  PersistenceHelper.swift
//  FlickrChallenge
//
//  Created by Cameron Rivera on 1/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

struct PersistenceHelper<T: Codable>{
    
    func getObjects() throws -> [T]{
        guard let data = FileManager.default.contents(atPath: url.path) else {
            return []
        }
        return try PropertyListDecoder().decode([T].self, from: data)
    }
    
    func save(_ newElement: T) throws {
        var elements = try getObjects()
        elements.append(newElement)
        let serializedData = try PropertyListEncoder().encode(elements)
        try serializedData.write(to: url, options: Data.WritingOptions.atomic)
    }
    
     init(fileName: String){
        self.fileName = fileName
     }
     
     private var fileName: String
     
     private var url: URL {
        return filePathFromDocumentsDirectory(fileName)
     }
    
    private func documentsDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func filePathFromDocumentsDirectory(_ filename: String) -> URL{
        return documentsDirectory().appendingPathComponent(filename)
    }
}
