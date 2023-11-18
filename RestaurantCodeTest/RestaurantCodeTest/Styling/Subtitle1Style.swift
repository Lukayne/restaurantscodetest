//
//  Subtitle1Style.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

extension LabelStyle where Self == Subtitle1Style {
    static var subtitle1: Subtitle1Style {
        Subtitle1Style()
    }
}

struct Subtitle1Style: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .font(.custom("Helvetica-Regular", size: 12)
                .weight(.bold))
            .foregroundColor(.black)
            .frame(width: 122, height: 18, alignment: .topLeading)
    }
}
