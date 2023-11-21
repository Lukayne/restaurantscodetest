//
//  RestaurantsDetailViewModel.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation
import Combine

// MARK: Not implemented at the moment.
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
    
    func getOpenStatusText() -> String {
        // MARK: The strings wouldn't be used like this, they would instead come from Localizable.
        return restaurantOpenStatus.isCurrentlyOpen ? "Open" : "Closed"
    }

    private func loadOpenStatus() {
        resturantDetailState = .loadingDetailStatus
        
        let service = RestaurantService(networkRequest: NativeRequestable(), environment: .development)
        service.getOpenStatusForRestaurant(restaurantId: restaurant.restaurant.id)
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    self?.resturantDetailState = .error
                    print("\(error.localizedDescription)")
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] (response) in
                self?.resturantDetailState = .finishedLoading
                self?.restaurantOpenStatus = response
            }
            .store(in: &bag)
    }
}
