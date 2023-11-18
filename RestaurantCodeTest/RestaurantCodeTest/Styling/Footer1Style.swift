//
//  Footer1Style.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

extension LabelStyle where Self == Footer1Style {
    static var footer1: Footer1Style {
        Footer1Style()
    }
}

struct Footer1Style: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.title
            .font(.custom("Inter-Regular", size: 10)
                .weight(.medium))
            .foregroundColor(.black)
            .frame(width: 122, height: 18, alignment: .topLeading)
    }
}
