//
//  TextFooter1.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct TextFooter1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Inter-Regular", size: 10)
                .weight(.medium))
            .frame(width: 122, height: 18, alignment: .topLeading)
    }
}

