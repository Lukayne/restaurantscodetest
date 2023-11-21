//
//  SubtitleDetailCard.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct SubtitleDetailCard: View {
    
    @ObservedObject var restaurantDetailViewModel: RestaurantDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(restaurantDetailViewModel.restaurant.restaurant.name)
                .modifier(TextHeadline1())
                .foregroundColor(darkTextColor)
                .frame(width: 311, height: 42, alignment: .leading)
            Spacer()
            Text(restaurantDetailViewModel.restaurant.filterNames.joined(separator: " - "))
                .modifier(TextSubtitle1())
                .frame(width: 311, height: 35, alignment: .leading)
                .foregroundColor(subTitleColor)
            Spacer()
            Text(restaurantDetailViewModel.getOpenStatusText())
                .modifier(TextTitle1())
                .foregroundColor(restaurantDetailViewModel.restaurantOpenStatus.isCurrentlyOpen ? positiveColor : negativeColor)
                .frame(width: 311, height: 35, alignment: .leading)
        }
        .padding(16)
        .frame(width: 343, height: 144, alignment: .leading)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
    }
}

struct SubtitleDetailCard_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleDetailCard(restaurantDetailViewModel: RestaurantDetailViewModel(restaurant: RestaurantWrapper(restaurant: Restaurant(id: "SOMEID", name: "NAME", rating: 10, filterIds: ["filterid", ".."], imageURL: "imageURL", deliveryTimeInMinutes: 50))))
    }
}
