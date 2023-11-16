//
//  RestaurantsListView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantsListView: View {
    @ObservedObject var restaurantListViewModel: RestaurantListViewModel
    
    var body: some View {
        switch restaurantListViewModel.restaurantState {
        case .loading:
            ProgressView()
        case .error:
            Text("Error")
        case .success:
            List {
                ForEach(restaurantListViewModel.restaurants, id: \.id) { restaurant in
                    RestaurantCardView(image: Image("image"), restaurantName: restaurant.name, restaurantTags: restaurant.filterIds.joined(), rating: String(restaurant.rating))
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
