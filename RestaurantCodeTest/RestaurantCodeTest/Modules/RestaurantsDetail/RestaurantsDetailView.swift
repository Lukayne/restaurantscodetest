//
//  RestaurantDetailView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    @ObservedObject var restaurantDetailViewModel: RestaurantDetailViewModel
    @StateObject private var imageLoader: ImageLoader
    
    init(restaurantDetailViewModel: RestaurantDetailViewModel) {
        self.restaurantDetailViewModel = restaurantDetailViewModel
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: restaurantDetailViewModel.restaurant.restaurant.imageURL))
    }
    
    var body: some View {
        ZStack {
            restaurantImage
            backButtonImage
            subTitleDetailCard
        }
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        .onAppear(perform: restaurantDetailViewModel.onAppear)
    }
    
    @ViewBuilder private var restaurantImage: some View {
        Rectangle()
        .foregroundColor(.clear)
        .frame(width: 375, height: 220)
        .background(
            (
                imageLoader.image != nil ?
                AnyView(
                    imageLoader.image!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 375, height: 220)
                        .clipped()
                ) : AnyView(ProgressView())
            )
        )
    }
    
    @ViewBuilder private var backButtonImage: some View {
        Image("Chevron")
        .frame(width: 11, height: 17)
        .shadow(color: .white.opacity(0.25), radius: 2, x: 0, y: 4)
    }
        
    @ViewBuilder private var subTitleDetailCard: some View {
        SubtitleDetailCard(restaurantDetailViewModel: restaurantDetailViewModel)
            .padding(16)
            .offset(y: 175)
    }
}

struct RestaurantsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(restaurantDetailViewModel: RestaurantDetailViewModel(restaurant: RestaurantWrapper(restaurant: Restaurant(id: "someID", name: "Restaurang S", rating: 4.5, filterIds: [""], imageURL: "IMAGEURL", deliveryTimeInMinutes: 50))))
    }
}
