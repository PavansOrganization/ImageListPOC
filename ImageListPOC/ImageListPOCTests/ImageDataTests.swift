//
//  RequestWrapperTests.swift
//  ImageListPOCTests
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import ImageListPOC
@testable import Alamofire

class RequestWrapperTests: XCTestCase {
    
    var requestWrapper: RequestWrapper!
    
    override func setUp() {
        requestWrapper = RequestWrapper()
    }
    
    override func tearDown() {
        requestWrapper = nil
    }
    
    func testRequestWrapperURL() {
        let requestExpectation  = expectation(description: "Testing, make request with dummy request")
        guard let url = URL(string: "https://mockURL") else {
            return
        }
        
        requestWrapper.makeRequest(urlString: "https://mockURL") { (dataResponse) in
            XCTAssertEqual(url, dataResponse?.request?.url)
            requestExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testRequestWrapperResponse() {
        let responseExpectation  = expectation(description: "Response expectation")
        
        requestWrapper.makeRequest(urlString: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json") { (dataResponse) in
            XCTAssertNotNil(dataResponse, "dataResponse should not be nil")
            responseExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
}
