//
//  Requestable.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Combine
import Foundation

public protocol Requestable {
    
    func request<T: Decodable>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
}

public class NativeRequestable: Requestable {

    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, NetworkError>
     where T: Decodable {
        
        guard let url = URL(string: req.url) else {
            // Return a fail publisher if the url is invalid
            return AnyPublisher(
                Fail<T, NetworkError>(error: NetworkError.badURL("Invalid Url"))
            )
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                     // throw an error if response is nil
                guard output.response is HTTPURLResponse else {
                    throw NetworkError.serverError(code: 0, error: "Server error")
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                       // return error if json decoding fails
                NetworkError.invalidJSON(String(describing: error))
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

public struct NetworkRequest {
    let url: String
    let headers: [String: String]?
    let body: Data?
    let httpMethod: HTTPMethod
    
    public init(url: String,
                headers: [String: String]? = nil,
                reqBody: Encodable? = nil,
                reqTimeout: Float? = nil,
                httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody?.encode()
        self.httpMethod = httpMethod
    }
    
    public init(url: String,
                headers: [String: String]? = nil,
                reqBody: Data? = nil,
                reqTimeout: Float? = nil,
                httpMethod: HTTPMethod
    ) {
        self.url = url
        self.headers = headers
        self.body = reqBody
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

public enum NetworkError: Error, Equatable {
    case badURL(_ error: String)
    case apiError(code: Int, error: String)
    case invalidJSON(_ error: String)
    case unauthorized(code: Int, error: String)
    case badRequest(code: Int, error: String)
    case serverError(code: Int, error: String)
    case noResponse(_ error: String)
    case unableToParseData(_ error: String)
    case unknown(code: Int, error: String)
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}

public typealias Headers = [String: String]

// if you wish you can have multiple services like this in a project
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
    
//  // compose the NetworkRequest
//    func createRequest(token: String, environment: Environment) -> NetworkRequest {
//        var headers: Headers = [:]
//        headers["Content-Type"] = "application/json"
//        headers["Authorization"] = "Bearer \(token)"
//        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
//    }
    
    func createRequest(environment: Environment) -> NetworkRequest {
        var headers: Headers = [:]
        headers["accept"] = "application/json"
        return NetworkRequest(url: getURL(from: environment), headers: headers, reqBody: nil, httpMethod: httpMethod)
    }
    
//  // encodable request body for POST
//    var requestBody: Encodable? {
//        switch self {
//        case .purchaseProduct(let request):
//            return request
//        default:
//            return nil
//        }
//    }
    
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

//    func purchaseProduct(request: PurchaseRequest) -> AnyPublisher<PurchaseResponse, NetworkError> {
//        let endpoint = PurchaseServiceEndpoints.purchaseProduct(request: request)
//        let request = endpoint.createRequest(token: token,
//                                             environment: self.environment)
//        return self.networkRequest.request(request)
//    }
    
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
    }
    
}
