//
//  RestaurantCardView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantCardView: View {
    var restaurantWrapper: RestaurantWrapper

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(
                        // Use cached image if available, otherwise use placeholder
                        (restaurantWrapper.image != nil ?
                            AnyView(
                                restaurantWrapper.image!
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 343, height: 132)
                                    .clipped()
                            ) :
                            AnyView(Image("placeholder"))
                        )
                    )
                    .cornerRadius(12)
                HStack(alignment: .top, spacing: 18) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(restaurantWrapper.restaurant.name)
                            .modifier(TextTitle1())
                            .foregroundColor(darkTextColor)
                        Text(restaurantWrapper.filterNames.joined(separator: ", "))
                            .modifier(TextSubtitle1())
                            .foregroundColor(subTitleColor)
                        ZStack {
                            Image("clock_icon")
                                .frame(width: 10, height: 10)
                            Text("\(restaurantWrapper.restaurant.deliveryTimeInMinutes)")
                                .modifier(TextFooter1())
                                .foregroundColor(footerColor)
                        }
                        .frame(width: 138, height: 12)
                    }
                    .padding(0)
                    .frame(width: 278, alignment: .topLeading)
                    HStack(alignment: .top, spacing: 3) {
                        Image("star_icon")
                            .frame(width: 12, height: 12)
                        Text(restaurantWrapper.formattedRating)
                            .modifier(TextFooter1())
                            .foregroundColor(footerColor)
                    }
                    .padding(0)
                }
                .padding(.horizontal, 8)
                .padding(.top, 0)
                .padding(.bottom, 8)
            }
            .padding(0)
            .frame(width: 343, alignment: .leading)
            .background(.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
        }
        .padding(0)
        .frame(width: 343, height: 196, alignment: .center)
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 4)
    }
}


//struct RestaurantCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        RestaurantCardView(image: Image(""), restaurantName: "Krögarn", restaurantTags: "Tag tag tag", rating: "4.3", deliveryTime: "30 mins")
//    }
//}
