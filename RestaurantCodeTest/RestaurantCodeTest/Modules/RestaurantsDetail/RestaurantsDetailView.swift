//
//  RestaurantsDetailView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantsDetailView: View {
    
    @StateObject var restaurantDetailViewModel: RestaurantDetailViewModel
    
    var body: some View {
        VStack {
            subTitleDetailCard
        }
    }
    
    
    @ViewBuilder private var subTitleDetailCard: some View {
        SubtitleDetailCard()
    }
}

struct RestaurantsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsDetailView(restaurantDetailViewModel: RestaurantDetailViewModel())
    }
}
