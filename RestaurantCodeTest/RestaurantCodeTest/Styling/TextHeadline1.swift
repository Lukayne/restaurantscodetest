//
//  TextHeadline1.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct TextHeadline1: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica-Regular", size: 24))
//            .frame(width: 141, height: 18, alignment: .topLeading)
    }
}
