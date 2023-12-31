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
