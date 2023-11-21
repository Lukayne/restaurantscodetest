//
//  RestaurantService.swift
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
    
    func getFilter(filterId: String) -> AnyPublisher<Filter, NetworkError> {
        let endpoint = RestaurantServiceEndpoints.getFilter(filterId: filterId)
        let request = endpoint.createRequest(environment: environment)
        
        return self.networkRequest.request(request)
    }
    
    func getOpenStatusForRestaurant(restaurantId: String) -> AnyPublisher<OpenStatus, NetworkError> {
        let endpoint = RestaurantServiceEndpoints.getOpenStatusForRestaurant(restaurantId: restaurantId)
        let request = endpoint.createRequest(environment: environment)
        
        return self.networkRequest.request(request)
//            .tryMap { (data: Data) -> OpenStatus in
//                // Assuming OpenStatus is Decodable
//                let decoder = JSONDecoder()
//                return try decoder.decode(OpenStatus.self, from: data)
//            }
//            .mapError { error in
//                // Check if the error is a 404 error
//                if let networkError = error as? NetworkError, case .apiError(let code, _) = networkError, code == 404 {
//                    // Attempt to extract the data from the userInfo dictionary
//                    if let urlError = error as? URLError, let responseData = urlError.userInfo[NSLocalizedRecoverySuggestionErrorKey] as? Data {
//                        do {
//                            // Decode the error response as RestaurantError
//                            let decoder = JSONDecoder()
//                            let restaurantError = try decoder.decode(RestaurantError.self, from: responseData)
//                            // Map RestaurantError to a more specific NetworkError
//                            return restaurantError.mapToNetworkError()
//                        } catch {
//                            // Error decoding the response as RestaurantError, return the original NetworkError
//                            return NetworkError.serverError(code: code, error: "\(error.localizedDescription)")
//                        }
//                    }
//                }
//                
//                // Return the original error
//                return NetworkError.unknown(code: 0, error: "\(error.localizedDescription)")
//            }
//            .eraseToAnyPublisher()
    }
}

extension RestaurantError {
    // Helper function to map RestaurantError to NetworkError
    func mapToNetworkError() -> NetworkError {
        return NetworkError.apiError(code: 404, error: self.reason)
    }
}

