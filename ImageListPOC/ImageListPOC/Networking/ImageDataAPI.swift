//
//  ImageDataAPI.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
import Alamofire

class ImageDataAPI: WebService {
    
    private let requestProtocol: RequestProtocol
    init(requestProtocol: RequestProtocol = RequestWrapper()) {
        self.requestProtocol = requestProtocol
    }
    /*
     Here we are receving all facts data and parcing it through JSONDecoder to our custom objects.
     */
    func getFactsData(callback: @escaping WebService.FactsDataCallback) {
        let urlString = AppConstants.baseUrl + "facts.json"
        requestProtocol.makeRequest(urlString: urlString) { (jsonString) in
            guard let jsonData = jsonString?.result.value?.data(using: String.Encoding.utf8) else {
                callback(nil, jsonString?.error.debugDescription)
                return
            }
            do {
                let factsObject = try JSONDecoder().decode(Facts.self, from: jsonData)
                callback(factsObject, nil)
            } catch let error {
                callback(nil, error.localizedDescription)
            }
        }
    }
}
