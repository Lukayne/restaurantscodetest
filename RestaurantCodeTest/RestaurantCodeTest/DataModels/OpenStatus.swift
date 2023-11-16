//
//  OpenStatus.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation

struct OpenStatus: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case restaurantID = "restaurant_id"
        case isCurrentlyOpen = "is_currently_open"
    }
    
    let restaurantID: String
    let isCurrentlyOpen: Bool
}
