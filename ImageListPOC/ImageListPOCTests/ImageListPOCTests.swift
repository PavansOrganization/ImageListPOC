//
//  ImageListPOCTests.swift
//  ImageListPOCTests
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import XCTest
@testable import ImageListPOC

class ImageListPOCTests: XCTestCase {
    
    var imageListViewController = ImageListViewController()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewController() {
        XCTAssertNotNil(imageListViewController, "ViewController must be there, it should not be a nil")
    }
    
    func testCollectionView() {
        // Checking for views added programatically on view controllers.
        
        let views = imageListViewController.view.subviews
        var collectionView: UICollectionView?
        
        for view in views {
            if view is UICollectionView {
                collectionView = view as? UICollectionView
                break
            }
        }
        
        XCTAssertNotNil(collectionView, "collectionView should not be a nil")
    }
    
    func testActivityIndicator() {
        //Checking for activity indicator
        
        imageListViewController.loadViewIfNeeded()
        
        XCTAssertEqual(imageListViewController.activityView.center, imageListViewController.view.center, "activityView should be center to superview")
        XCTAssertEqual(imageListViewController.activityView.color, UIColor.black, "activityView should be black in color")
        
        XCTAssertTrue(imageListViewController.activityView.hidesWhenStopped, "activityView should be gets stopped, when hides.")
        
        if Network.connectedToNetwork() { // Checking for activity Indicator is animating or not.
            XCTAssertTrue(imageListViewController.activityView.isAnimating, "activityIndicatorView should be animating")
        } else {
            XCTAssertFalse(imageListViewController.activityView.isAnimating, "activityIndicatorView should not be animating")
        }
    }
}
