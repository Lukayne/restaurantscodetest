//
//  RestaurantError.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation

struct RestaurantError: Decodable {
    
    let error: Bool
    let reason: String
}
