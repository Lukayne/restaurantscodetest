//
//  Filter.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation

struct Filter: Decodable, Identifiable, Equatable, Hashable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageURL = "image_url"
    }
    
    let id: String
    let name: String
    let imageURL: String
    
    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.imageURL == rhs.imageURL
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

}
