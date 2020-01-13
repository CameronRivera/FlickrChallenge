//
//  FlickrChallengeTests.swift
//  FlickrChallengeTests
//
//  Created by Cameron Rivera on 1/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import XCTest
@testable import FlickrChallenge

class FlickrChallengeTests: XCTestCase {

    func testGetPhoto(){
        // Arrange
        let exp = expectation(description: "Get some photos")
        
        // Act
        FlickrPhotoAPI.getPhotos(FlickrPhotoAPI.getNameURL("Bees")) { result in
            switch result{
            case .failure:
                break
            case .success(let photos):
                exp.fulfill()
                // Assert
                XCTAssertNotEqual(photos.count, 0, "\(photos.count) is equal to \(0)")
            }
        }
        wait(for: [exp], timeout: 5.0)
    }

}
