//
//  RestaurantSerivce.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-18.
//

import Foundation
import Combine

protocol RestaurantServiceable {
    func getAllRestaurants() -> AnyPublisher<Restaurants, NetworkError>
    func getFilter(filterId: String) -> AnyPublisher<Filter, NetworkError>
    func getOpenStatusForRestaurant(restaurantId: String) -> AnyPublisher<OpenStatus, NetworkError>
}

class RestaurantService: RestaurantServiceable {
    
    private var networkRequest: Requestable
    private var environment: Environment = .development
    
  // inject this for testability
    init(networkRequest: Requestable, environment: Environment) {
        self.networkRequest = networkRequest
        self.environment = environment
    }

    func getAllRestaurants() -> AnyPublisher<Restaurants, NetworkError> {
        let endpoint = RestaurantServiceEndpoints.getAllRestaurants
        let request = endpoint.createRequest(environment: environment)
        
        return self.networkRequest.request(request)
    }
    
//    func getFilter(filterId: String) -> AnyPublisher<Filter, NetworkError> {
//        let endpoint = RestaurantServiceEndpoints.getFilter(filterId: filterId)
//        let request = endpoint.createRequest(environment: environment)
//
//        return self.networkRequest.request(request)
//    }
    
    func getFilter(filterId: String) -> AnyPublisher<Filter, NetworkError> {
        let endpoint = RestaurantServiceEndpoints.getFilter(filterId: filterId)
        let request = endpoint.createRequest(environment: environment)

        return self.networkRequest.request(request)
            .mapError { error in
                // Handle network errors and convert them to NetworkError
                switch error {
                case let urlError as URLError:
                    return .badURL(urlError.localizedDescription)
                default:
                    return .unknown(code: 0, error: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }

    func getOpenStatusForRestaurant(restaurantId: String) -> AnyPublisher<OpenStatus, NetworkError> {
        let endpoint = RestaurantServiceEndpoints.getOpenStatusForRestaurant(restaurantId: restaurantId)
        let request = endpoint.createRequest(environment: environment)
        
        return self.networkRequest.request(request)
    }
}
