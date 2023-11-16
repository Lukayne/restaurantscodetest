//
//  Title2Style.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

extension LabelStyle where Self == Title2Style {
    static var title2: Title2Style {
        Title2Style()
    }
}

struct Title2Style: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .font(Font.custom("Poppins", size: 14)
                .weight(.medium))
            .foregroundColor(.black)
            .frame(width: 222, height: 18, alignment: .leading)
    }
}
