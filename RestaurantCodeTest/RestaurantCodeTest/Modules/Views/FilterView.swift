//
//  FilterView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-16.
//

import SwiftUI

struct FilterView: View {
    
    @ObservedObject var restaurantListViewModel: RestaurantListViewModel
    @StateObject private var imageLoader: ImageLoader
    var filter: Filter
    
    init(filter: Filter, restaurantListViewModel: RestaurantListViewModel) {
        self.filter = filter
        self.restaurantListViewModel = restaurantListViewModel
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: filter.imageURL))
    }
    
    var body: some View {
            filterChip
                .onTapGesture {
                    withAnimation(Animation.easeOut(duration: 0.3)) {
                        restaurantListViewModel.toggleFilter(filter)
                    }
                }
                .frame(height: 48)
    }
    
    @ViewBuilder private var filterChip: some View {
        HStack(alignment: .center, spacing: 8) {
            Rectangle()
                .foregroundStyle(.clear)
                .frame(width: 48, height: 48)
                .overlay(
                    (
                        imageLoader.image != nil ?
                        AnyView(
                            imageLoader.image!
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 48, height: 48)
                                .clipped()
                        ) : AnyView(ProgressView())
                    )
                )
            
            Text(filter.name)
                .modifier(TextTitle2())
                .foregroundColor(restaurantListViewModel.selectedFilters.contains(filter) ? lightText : .black)
        }
        .background(restaurantListViewModel.selectedFilters.contains(filter) ? selectedColor : Color.white.opacity(0.4))
        .padding(.leading, 0)
        .padding(.trailing, 16)
        .padding(.vertical, 0)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

    
struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filter: Filter(id: "id", name: "Top Rated", imageURL: "imageURL"), restaurantListViewModel: RestaurantListViewModel())
    }
}
