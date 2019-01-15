//
//  DownloadImageTest.swift
//  ImageListPOCTests
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import ImageListPOC

class DownloadImageTest: XCTestCase {
    
    var imageColectionViewCell: ImageCollectionViewCell!
    
    override func setUp() {
        imageColectionViewCell = ImageCollectionViewCell()
    }
    
    override func tearDown() {
        imageColectionViewCell = nil
    }
    
    /*
     Image should get downloaded, image should not be nil, and error object should be nil, always!
     */
    func testDownloadImage() {
        let expectation = XCTestExpectation(description: "Download image")
        imageColectionViewCell.imageView.sd_setImage(with: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")) { (image, error, _, _) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            expectation.fulfill()
        }
    }
}
