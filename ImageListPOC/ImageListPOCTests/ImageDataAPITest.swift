//
//  ImageDataAPITest.swift
//  ImageListPOCTests
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import ImageListPOC

class ImageDataAPITest: XCTestCase {
    
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
    func testFactDataAPI() {
        let factExpectation  = expectation(description: "Get facts data")
        
        imageDataAPI.getFactsData { (facts, message) in
            if Network.connectedToNetwork() {
                XCTAssertNil(message,"Message should be nil")
                XCTAssertNotNil(facts, "Facts should not be nil")
            } else {
                XCTAssertNil(facts, "Facts should be nil")
                XCTAssertNotNil(message,"Message not should be nil")
            }
            factExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
