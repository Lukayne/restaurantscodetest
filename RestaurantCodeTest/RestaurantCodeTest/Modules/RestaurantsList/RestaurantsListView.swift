//
//  RestaurantsListView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantsListView: View {
    @StateObject var restaurantListViewModel: RestaurantListViewModel
    
    @State private var isRestaurantDetailViewPresented = false
    
    var body: some View {
        switch restaurantListViewModel.restaurantState {
        case .loadingRestaurants, .loadingFilters:
            ProgressView()
        case .error:
            Text("Error")
        case .loadedRestaurants, .loadedFilters, .finishedLoading:
            VStack {
                filters
                restaurants
            }
            .sheet(isPresented: $isRestaurantDetailViewPresented) {
                RestaurantDetailView(restaurantDetailViewModel: RestaurantDetailViewModel(restaurant: restaurantListViewModel.selectedRestaurant))
            }
        }
    }
    
    @ViewBuilder private var filters: some View {
        LazyHStack(spacing: 16.0) {
            ForEach(restaurantListViewModel.filters, id: \.id) { filter in
                FilterView(filter: filter, isFilterSelected: false)
                    .id(filter.id)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder private var restaurants: some View {
        List {
            ForEach(restaurantListViewModel.restaurantsWithFilterNames, id: \.restaurant.id) { restaurantWrapper in
                RestaurantCardView(restaurantWrapper: restaurantWrapper)
                    .id(restaurantWrapper.restaurant.id)
                    .onTapGesture {
                        restaurantListViewModel.selectedRestaurant = restaurantWrapper
                        isRestaurantDetailViewPresented.toggle()
                    }
            }
        }
    }
}

struct RestaurantsListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsListView(restaurantListViewModel: RestaurantListViewModel())
    }
}
