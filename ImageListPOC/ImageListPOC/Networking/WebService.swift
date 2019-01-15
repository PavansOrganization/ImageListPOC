//
//  WebService.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
protocol WebService {
    typealias FactsDataCallback = ((Facts?, String?) -> Void)
    func getFactsData(callback: @escaping FactsDataCallback)
}
