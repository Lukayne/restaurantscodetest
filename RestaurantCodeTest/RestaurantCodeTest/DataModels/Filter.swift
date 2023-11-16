//
//  Filter.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation

struct Filter: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
    
    let id: String
    let name: String
    let imageURL: String
}
