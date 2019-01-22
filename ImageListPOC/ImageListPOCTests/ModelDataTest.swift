//
//  ModelDataTest.swift
//  ImageListPOCTests
//
//  Created by test on 21/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import ImageListPOC

class ModelDataTest: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFactData() {
        let jsonData = """
                            {
                             "title":"About Canada",
                             "rows":[
                                    {
                                    "title":"Fact title",
                                    "description":"Fact description",
                                    "imageHref":"path"
                                    }
                                    ]
                            }
                            """.data(using: .utf8)!
        
        let json = try! JSONDecoder().decode(Facts.self, from: jsonData)
        
        XCTAssertEqual(json.title, "About Canada")
        XCTAssertNotNil(json.rows, "Rows array should not be nil")
        XCTAssertTrue(json.rows?.count == 1, "rows array should have one object")
    }
    
    func testRowData() {
        let jsonData = """
                        {
                        "title":"Row title",
                        "description":"Row description",
                        "imageHref":"path"
                        }
                        """.data(using: .utf8)!
        
        let json = try! JSONDecoder().decode(Rows.self, from: jsonData)
        
        XCTAssertEqual(json.title, "Row title")
        XCTAssertEqual(json.description, "Row description")
        XCTAssertEqual(json.imageHref, "path")
    }
    
}
