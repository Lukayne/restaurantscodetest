//
//  ContentView.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var restaurantListViewModel: RestaurantListViewModel = { RestaurantListViewModel.shared } ()
 
    var body: some View {
        RestaurantsListView(restaurantListViewModel: restaurantListViewModel)
            .onAppear(perform: restaurantListViewModel.onAppear)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
