//
//  TextSubtitle1.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct TextSubtitle1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica-Regular", size: 12)
                .weight(.bold))
            .frame(width: 122, height: 18, alignment: .topLeading)
    }
}
