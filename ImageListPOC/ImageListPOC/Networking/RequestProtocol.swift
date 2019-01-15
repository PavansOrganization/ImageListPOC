//
//  RequestProtocol.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import Alamofire

// A protocol for making network requests

protocol RequestProtocol {
    func makeRequest(urlString: String, callback: @escaping (DataResponse<String>?) -> Void)
}
