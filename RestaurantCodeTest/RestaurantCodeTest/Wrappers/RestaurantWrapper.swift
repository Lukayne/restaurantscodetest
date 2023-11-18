//
//  RestaurantWrapper.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-18.
//

import Foundation
import SwiftUI

class RestaurantWrapper {
    var image: Image?
    var restaurant: Restaurant
    var filterNames: [String] = []
    var formattedRating: String {
        return String(format: "%.1f", restaurant.rating)
    }

    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
}
