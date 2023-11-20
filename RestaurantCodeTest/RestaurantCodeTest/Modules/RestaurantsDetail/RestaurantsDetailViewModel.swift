//
//  RestaurantsDetailViewModel.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation
import Combine

enum RestaurantDetailState: Equatable, CaseIterable {
    case loadingDetailStatus
    case error
    case finishedLoading
}

class RestaurantDetailViewModel: ObservableObject {
    
    @Published var resturantDetailState: RestaurantDetailState = .loadingDetailStatus
    @Published var restaurantOpenStatus: OpenStatus = OpenStatus(restaurantID: "", isCurrentlyOpen: false)
    @Published var restaurant: RestaurantWrapper
    
    private var bag = Set<AnyCancellable>()
    
    init(restaurant: RestaurantWrapper) {
        self.restaurant = restaurant
    }
    
    deinit {
        bag.removeAll()
    }
    
    
    func onAppear() {
        loadOpenStatus()
    }

    private func loadOpenStatus() {
        let service = RestaurantService(networkRequest: NativeRequestable(), environment: .development)
        service.getOpenStatusForRestaurant(restaurantId: restaurant.restaurant.id)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    print("Error loading open status for \(self?.restaurant.restaurant.id): \(error.localizedDescription)")
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] (response) in
                print("RESPONSE; \(response)")
                self?.restaurantOpenStatus = response
            }
            .store(in: &bag)
    }
}
