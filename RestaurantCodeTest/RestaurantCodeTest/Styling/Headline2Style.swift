//
//  Headline2Style.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

extension LabelStyle where Self == Headline2Style {
    static var headline1: Headline2Style {
        Headline2Style()
    }
}

struct Headline2Style: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .font(Font.custom("Helvetica", size: 16))
            .foregroundColor(.black)
            .frame(width: 141, height: 18, alignment: .topLeading)
    }
}
