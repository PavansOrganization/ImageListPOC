//
//  AppConstants.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import UIKit

class AppConstants {
    
    static let baseUrl = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/"
    static let genericErrorMessage = "Something went wrong."
    static let invalidURL = "Invalid URL"
    static let connectionError = "Please check your network connection!"
    static let alertTitle = "Alert"
    static let alertOK = "Ok"
    // MARK: - UI Constants
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidthForScaling: CGFloat = 375.0
    static let screenHeightForScaling: CGFloat = 667.0
    static let placeholderImage = UIImage(named: "Placeholder")
}
