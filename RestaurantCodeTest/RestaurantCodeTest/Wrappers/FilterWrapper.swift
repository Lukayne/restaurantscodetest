//
//  FilterWrapper.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-18.
//

import Foundation
import SwiftUI

class FilterWrapper {
    var image: Image?
    var filter: Filter
    
    init(filter: Filter) {
        self.filter = filter
    }
}
