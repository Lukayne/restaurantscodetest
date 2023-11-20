//
//  SubtitleDetailCard.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct SubtitleDetailCard: View {
    
    var openStatus: OpenStatus
    var restaurant: RestaurantWrapper
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(restaurant.restaurant.name)
                .modifier(TextHeadline1())
                .foregroundColor(darkTextColor)
            Spacer()
            Text(restaurant.filterNames.joined(separator: " - "))
                .modifier(TextSubtitle1())
                .frame(width: 311, height: 35, alignment: .leading)
                .foregroundColor(subTitleColor)
            Spacer()
            Text("\(openStatus.isCurrentlyOpen.description)")
                .modifier(TextTitle1())
                .foregroundColor(positiveColor)
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
        SubtitleDetailCard(openStatus: OpenStatus(restaurantID: "RESTAURANTID", isCurrentlyOpen: false), restaurant: RestaurantWrapper(restaurant: Restaurant(id: "RESTAURANTID", name: "Pepes", rating: 4.0, filterIds: [""], imageURL: "IMAGEURL", deliveryTimeInMinutes: 50)))
    }
}
