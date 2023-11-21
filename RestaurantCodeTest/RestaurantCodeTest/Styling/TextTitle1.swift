//
//  TextTitle1.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct TextTitle1: ViewModifier {
    
//    let width: CGFloat
//    let height: CGFloat
//    let alignment: Alignment
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Helvetica-Regular", size: 18))
//            .frame(width: width, height: height, alignment: alignment)
//            .frame(width: 222, height: 19, alignment: .leading)
    }
}
