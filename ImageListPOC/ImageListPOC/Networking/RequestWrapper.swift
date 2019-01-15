//
//  RequestWrapper.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import Alamofire

class RequestWrapper: RequestProtocol {
    func makeRequest(urlString: String, callback: @escaping (DataResponse<String>?) -> Void) {
        Alamofire.request(urlString).responseString { (jsonString) -> Void in
            callback(jsonString)
        }
    }
}
