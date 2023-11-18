//
//  SubtitleDetailCard.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct SubtitleDetailCard: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Title")
                .modifier(TextHeadline1())
                .foregroundColor(darkTextColor)
            Text("Subtitle")
                .modifier(TextHeadline2())
                .foregroundColor(subTitleColor)
            HStack(alignment: .center, spacing: 0) {
                
            }
            .padding(0)
            .frame(width: 311, height: 35, alignment: .center)
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
        SubtitleDetailCard()
    }
}
