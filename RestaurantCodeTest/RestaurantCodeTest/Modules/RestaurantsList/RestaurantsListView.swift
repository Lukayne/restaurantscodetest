//
//  RestaurantsListView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantsListView: View {
    @StateObject var restaurantListViewModel: RestaurantListViewModel
    
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
        }
    }
    
    @ViewBuilder private var restaurants: some View {
        List {
            ForEach(restaurantListViewModel.restaurantsWithFilterNames, id: \.restaurant.id) { restaurantWrapper in
                RestaurantCardView(restaurantWrapper: restaurantWrapper)
                    .id(restaurantWrapper.restaurant.id)
            }
        }
    }
    
    @ViewBuilder private var filters: some View {
        List {
            ForEach(restaurantListViewModel.filtersWithImages, id: \.filter.id) { filterWrapper in
                FilterView(filterWrapper: filterWrapper)
                    .id(filterWrapper.filter.id)
            }
        }
    }
}

struct RestaurantsListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsListView(restaurantListViewModel: RestaurantListViewModel())
    }
}
