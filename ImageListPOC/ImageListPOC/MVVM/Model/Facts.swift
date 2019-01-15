//
//  Facts.swift
//  ImageListPOC
//
//  Created by test on 15/01/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
struct Facts: Codable {
    let title: String?
    let rows: [Rows]?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case rows = "rows"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
    }
}
