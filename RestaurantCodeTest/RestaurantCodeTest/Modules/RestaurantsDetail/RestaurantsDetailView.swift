//
//  RestaurantDetailView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    @StateObject var restaurantDetailViewModel: RestaurantDetailViewModel
    
    var body: some View {
        ZStack {
            
            subTitleDetailCard
        }
        .onAppear(perform: restaurantDetailViewModel.onAppear)
    }
        
    @ViewBuilder private var subTitleDetailCard: some View {
        SubtitleDetailCard(openStatus: restaurantDetailViewModel.restaurantOpenStatus, restaurant: restaurantDetailViewModel.restaurant)
    }
}

struct RestaurantsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurantDetailViewModel: RestaurantDetailViewModel(restaurant: RestaurantWrapper(restaurant: Restaurant(id: "someID", name: "Restaurang S", rating: 4.5, filterIds: [""], imageURL: "IMAGEURL", deliveryTimeInMinutes: 50))))
    }
}
