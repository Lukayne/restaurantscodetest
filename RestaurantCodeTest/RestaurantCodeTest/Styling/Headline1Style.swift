//
//  Headline1Style.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

extension LabelStyle where Self == Headline1Style {
    static var headline1: Headline1Style {
        Headline1Style()
    }
}

struct Headline1Style: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .font(Font.custom("Helvetica", size: 24))
            .foregroundColor(.black)
            .frame(width: 141, height: 18, alignment: .topLeading)
    }
}
