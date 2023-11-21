//
//  RestaurantServiceEndpoints.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-18.
//

import Foundation

enum RestaurantServiceEndpoints {
    
  // organise all the end points here for clarity
    case getAllRestaurants
    case getFilter(filterId: String)
    case getOpenStatusForRestaurant(restaurantId: String)
    
  //specify the type of HTTP request
    var httpMethod: HTTPMethod {
        switch self {
        case    .getAllRestaurants,
                .getFilter,
                .getOpenStatusForRestaurant:
            return .GET
        }
    }
        
    func createRequest(environment: Environment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["accept"] = "application/json"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: nil, httpMethod: httpMethod)
    }
    
  // compose urls for each request
    func getURL(from environment: Environment) -> String {
        let baseUrl = environment.purchaseServiceBaseUrl
        switch self {
        case .getAllRestaurants:
            return "\(baseUrl)/restaurants"
        case .getFilter(let filterId):
            return "\(baseUrl)/filter/\(filterId)"
        case .getOpenStatusForRestaurant(let restaurantId):
            return "\(baseUrl)/open/\(restaurantId)"
        }
    }
}


public enum Environment: String, CaseIterable {
    case development
    case staging
    case production
}

extension Environment {
    var purchaseServiceBaseUrl: String {
        switch self {
        case .development:
            return "https://food-delivery.umain.io/api/v1"
        case .staging:
            return "https://food-delivery.umain.io/api/v1"
        case .production:
            return "https://food-delivery.umain.io/api/v1"
        }
    }
}
