//
//  RestaurantCardView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct RestaurantCardView: View {
    
    var image: Image
    var restaurantName: String
    var restaurantTags: String
    var rating: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        Image("")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 343, height: 132)
                            .clipped()
                    )
                    .cornerRadius(12)
                HStack(alignment: .top, spacing: 18) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(restaurantName)
                            .labelStyle(.title1)
//                            .foregroundColor(Color(darkTextColor ?? .red))
                        Text(restaurantTags)
                            .labelStyle(.subtitle1)
//                            .foregroundColor(Color(subTitleColor ?? .red))
                    }
                    .padding(0)
                    .frame(width: 278, alignment: .topLeading)
                    HStack(alignment: .top, spacing: 3) {
                        Image("star icon")
                            .frame(width: 12, height: 12)
                            .background(Color(red: 0.98, green: 0.79, blue: 0.14))
                        Text(rating)
                            .font(
                                Font.custom("Inter", size: 10)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.31, green: 0.33, blue: 0.36))
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
//        RestaurantCardView(image: Binding<Image>(), restaurantName: (), restaurantTags: <#T##Binding<String>#>, rating: <#T##Binding<String>#>)
//    }
//}
