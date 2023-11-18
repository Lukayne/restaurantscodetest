//
//  Restaurant.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation

struct Restaurant: Decodable, Identifiable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case filterIds
        case imageURL = "image_url"
        case deliveryTimeInMinutes = "delivery_time_minutes"
    }
    
    let uuID = UUID ()
    
    let id: String
    let name: String
    let rating: Float
    let filterIds: [String]
    let imageURL: String
    let deliveryTimeInMinutes: Int
}
