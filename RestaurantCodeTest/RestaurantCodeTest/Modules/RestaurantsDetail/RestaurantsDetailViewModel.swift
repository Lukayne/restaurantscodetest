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
    
    
    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
    
    deinit {
        bag.removeAll()
    }
    
    
    func onAppear() {
        loadOpenStatus()
    }

    private func loadOpenStatus() {
        
    }
}
