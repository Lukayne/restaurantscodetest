//
//  RestaurantsListViewModel.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation
import Combine

enum RestaurantState: Equatable, CaseIterable {
    case loading
    case error
    case success
}

class RestaurantListViewModel: ObservableObject {
    
    static let shared = RestaurantListViewModel()
    
    @Published var restaurantState: RestaurantState = .loading
    @Published var restaurants: [Restaurant] = []

    private var networkHandler = RestaurantsNetworkHandler()
    private var bag = Set<AnyCancellable>()

    init() {
        
    }
    
    deinit {
        bag.removeAll()
    }
    
    func onAppear() {
        loadAllRestaurants()
    }
    
    private func loadAllRestaurants() {
        restaurantState = .loading
        
        let service = RestaurantService(networkRequest: NativeRequestable(), environment: .development)
        service.getAllRestaurants()
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    self?.restaurantState = .error
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] response in
                self?.restaurants = response.restaurants
                self?.restaurantState = .success
            }
            .store(in: &bag)
    }
    
    private func filterIDs() {
        var filterIDs = restaurants.flatMap { $0.filterIds }
        
        
        var filterIDsWithoutDuplicates = filterIDs
        
        filterIDsWithoutDuplicates = filterIDsWithoutDuplicates.filter { filterIDs.contains($0) }
    }
}
