//
//  ImageDataTests.swift
//  ImageListPOCTests
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import ImageListPOC

class ImageDataTests: XCTestCase {

    var imageDataAPI: WebService!
    
    override func setUp() {
        imageDataAPI = ImageDataAPI()
    }
    
    override func tearDown() {
        imageDataAPI = nil
    }
    
    /*
     Facts data from the given URL is receiving or not.
     */
    func testImageDataAPI() {
        imageDataAPI.getFactsData { (facts, message) in
            XCTAssertNil(message)
            XCTAssertNotNil(facts)
        }
    }
}
