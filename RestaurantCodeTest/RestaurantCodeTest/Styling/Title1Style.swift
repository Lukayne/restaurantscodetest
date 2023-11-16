//
//  Title1Style.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

extension LabelStyle where Self == Title1Style {
    static var title1: Title1Style {
        Title1Style()
    }
}

struct Title1Style: LabelStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        Label(configuration)
            .font(Font.custom("Helvetica", size: 18))
            .foregroundColor(.black)
            .frame(width: 222, height: 19, alignment: .leading)
    }
}
