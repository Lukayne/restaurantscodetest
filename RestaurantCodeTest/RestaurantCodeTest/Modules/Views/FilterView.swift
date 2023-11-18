//
//  FilterView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct FilterView: View {
    
    var filterWrapper: FilterWrapper
    
    @State var isFilterSelected: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
        }
        .padding(0)
        .frame(width: 144, height: 48, alignment: .center)
    }
    
    @ViewBuilder private var filter: some View {
        HStack(alignment: .center, spacing: 8) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 48, height: 48)
              .background(
                Image("PLACEHOLDER")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 48, height: 48)
                  .clipped()
              )
            Text("Top rated")
                .modifier(TextTitle2())
        }
        .padding(.leading, 0)
        .padding(.trailing, 16)
        .padding(.vertical, 0)
        .background(.white.opacity(0.4))
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 4)

    }
    
    @ViewBuilder private var filterSelected: some View {
        HStack(alignment: .center, spacing: 8) {
            Rectangle()
              .foregroundColor(.clear)
              .frame(width: 48, height: 48)
              .background(
                Image("PLACEHOLDER")
                  .resizable()
                  .aspectRatio(contentMode: .fill)
                  .frame(width: 48, height: 48)
                  .clipped()
              )
            Text("Top rated / selected")
                .modifier(TextTitle2())
                .foregroundColor(lightText)
        }
        .padding(.leading, 0)
        .padding(.trailing, 16)
        .padding(.vertical, 0)
        .background(selectedColor)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.04), radius: 5, x: 0, y: 4)

    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filterWrapper: FilterWrapper(filter: Filter(id: "id", name: "Top Rated", imageURL: "imageURL")), isFilterSelected: false)
    }
}
