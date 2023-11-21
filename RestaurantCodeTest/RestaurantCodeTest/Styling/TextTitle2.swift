//
//  TextTitle2.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct TextTitle2: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Poppins-Regular", size: 14)
                .weight(.medium))
//            .frame(width: 222, height: 18, alignment: .leading)
    }
}
