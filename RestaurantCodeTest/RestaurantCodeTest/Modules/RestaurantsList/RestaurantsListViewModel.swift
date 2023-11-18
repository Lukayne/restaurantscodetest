//
//  RestaurantsListViewModel.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Foundation
import Combine
import SwiftUI

enum RestaurantState: Equatable, CaseIterable {
    case loadingFilters
    case loadingRestaurants
    case error
    case loadedRestaurants
    case loadedFilters
    case finishedLoading
}

class RestaurantListViewModel: ObservableObject {
    
    static let shared = RestaurantListViewModel()
    
    @Published var restaurantState: RestaurantState = .loadingRestaurants

    @Published var restaurantsWithFilterNames: [RestaurantWrapper] = []
    @Published var filtersWithImages: [FilterWrapper] = []
    
    @Published private var imagesToLoadRestaurant: [String: String] = [:]
    @Published private var filterNames: [String] = []

    private var bag = Set<AnyCancellable>()
    
    init() {
        
    }
    
    deinit {
        bag.removeAll()
    }
    
    func onAppear() {
        loadAllRestaurants()
    }
    
    private func loadAllRestaurants() {
        restaurantState = .loadingRestaurants

        let service = RestaurantService(networkRequest: NativeRequestable(), environment: .development)
        service.getAllRestaurants()
            .sink { [weak self] (completion) in
                switch completion {
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    self?.restaurantState = .error
                case .finished:
                    print("")
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }

                // Create an array of RestaurantWrapper instances
                let restaurantWrappers: [RestaurantWrapper] = response.restaurants.map { RestaurantWrapper(restaurant: $0) }

                // Use Combine's MergeMany to handle multiple asynchronous requests for filter objects
                let filterRequests = response.restaurants
                    .flatMap { restaurant in
                        restaurant.filterIds.map { filterID in
                            service.getFilter(filterId: filterID)
                                .replaceError(with: Filter(id: "", name: "", imageURL: ""))
                                .map { $0.name }
                        }
                    }

                let cancellable = Publishers.MergeMany(filterRequests)
                    .collect()
                    .sink { filterNames in
                        let groupedFilterNames = Dictionary(grouping: filterNames.enumerated(), by: { $0.offset / restaurantWrappers.count })

                        for (index, group) in groupedFilterNames {
                            let restaurantIndex = index % restaurantWrappers.count
                            restaurantWrappers[restaurantIndex].filterNames = group.map { $0.element }
                        }

                        // Update each restaurant with corresponding filter names
                        self.restaurantsWithFilterNames = restaurantWrappers

                        // Load images for all restaurants
                        for wrapper in restaurantWrappers {
                            self.loadImageForRestaurant(
                                id: wrapper.restaurant.id,
                                stringURL: wrapper.restaurant.imageURL
                            )
                        }
                        
                        

                        // Assuming `restaurantState` is a non-optional property
                        self.restaurantState = .finishedLoading
                    }
                self.bag.insert(cancellable)
            }
            .store(in: &bag)
    }

    private func loadImage(id: String, stringURL: String) {
        let imageLoader = ImageLoader(url: stringURL)
        
        imageLoader.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadedImage in
                // Handle the loaded image here
                if let loadedImage = loadedImage {
                    // Update the corresponding RestaurantWrapper's image property
                    if let restaurantWrapper = self?.restaurantsWithFilterNames.first(where: { $0.restaurant.id == id }) {
                        restaurantWrapper.image = loadedImage
                    }
                }
            }
            .store(in: &bag)
    }
    
    private func loadImageForFilter(id: String, stringURL: String) {
        
        let imageLoader = ImageLoader(url: stringURL)
        
        imageLoader.$image
            .receive(on: DispatchQueue.main)
            .sink { [weak self] loadedFilterImage in
                if let loadedFilterImage = loadedFilterImage {
                    if let filterWrapper = self?.filtersWithImages.first(where: { $0.filter.id == id }) {
                        filterWrapper.image = loadedFilterImage
                    }
                }
            }
            .store(in: &bag)
    }
    
    // Function to trigger image loading
    func loadImageForRestaurant(id: String, stringURL: String) {
        // Update the imagesToLoad dictionary
        imagesToLoadRestaurant[id] = stringURL
        
        // Load the image
        loadImage(id: id, stringURL: stringURL)
    }
}


// TODO: Check if this is still needed or not

//    private func loadAllRestaurants() {
//        restaurantState = .loadingRestaurants
//
//        let service = RestaurantService(networkRequest: NativeRequestable(), environment: .development)
//        service.getAllRestaurants()
//            .sink { [weak self] (completion) in
//                switch completion {
//                case .failure(let error):
//                    print("\(error.localizedDescription)")
//                    self?.restaurantState = .error
//                case .finished:
//                    print("")
//                }
//            } receiveValue: { [weak self] response in
//                self?.restaurants = response.restaurants
//                self?.restaurantState = .loadedRestaurants
//            }
//            .store(in: &bag)
//    }

//    private func loadFilterName(filterID: String) {
//        let service = RestaurantService(networkRequest: NativeRequestable(), environment: .development)
//
//        service.getFilter(filterId: filterID)
//            .sink { [weak self] (completion) in
//                switch completion {
//                case .failure(let error):
//                    print("\(error.localizedDescription)")
//                    self?.restaurantState = .error
//                case .finished:
//                    print("")
//                }
//            } receiveValue: { [weak self] response in
//                self?.filters.append(response)
//
//                if self?.filterNames.count == self?.filters.count {
//                    self?.restaurantState = .finishedLoading
//                }
//            }
//            .store(in: &bag)
//      }


//        $restaurants
//            .compactMap { restaurants in
//                var result: [String] = []
//                result =  restaurants.flatMap { $0.filterIds }
//                var resultWithoutDuplicates = result
//                resultWithoutDuplicates = resultWithoutDuplicates.filter { result.contains($0)}
//                return resultWithoutDuplicates
//            }
//            .assign(to: &$filterNames)
//
//        $restaurants
//            .sink (receiveValue: { restaurants in
//                self.imagesToLoad = restaurants.reduce(into: [String:String]()) {
//                    $0[$1.id] = $1.imageURL
//                }
//
//                for (id, imageURL) in self.imagesToLoad {
//                    self.loadImage(id: id, stringURL: imageURL)
//                }
//            })
//            .store(in: &bag)
//
//        $restaurants
//            .sink(receiveValue: { restaurants in
//                self.filterNameForRestaurant = restaurants.reduce(into: [String:[String]]()) {
//                    $0[$1.id] = [""]
//                }
//            })
//            .store(in: &bag)
//
//        $filterNames
//            .sink(receiveValue: { [weak self] filters in
//                for id in filters {
//                    self?.restaurantState = .loadingFilters
//                    self?.loadFilterName(filterID: id)
//                }
//            })
//            .store(in: &bag)
//
//        $filters
//            .sink(receiveValue: { [weak self] filters in
//
//                self?.updateFilterBasedOnArray(filterObjects: filters)
//
////                self.filterNameForRestaurant = filters.reduce(into: [String:[String]]()) {
////
////                    var currentValue = self.filterNameForRestaurant[$1.id]
////
////                    if currentValue?.contains($1.name) != nil {
////
////                        currentValue?.append($1.name)
////
////                        $0.updateValue(, forKey: <#T##String#>)
////                        $0.updateValue(currentValue?.append($1.name) ?? [""], forKey: $1.id)
////                    }
//
//
//
////                    $0.filter { dictionary in
////                        self.filterNameForRestaurant.updateValue($1.name, forKey: $1.id)
////                    }
//                print("Updated VALUE of filterNameForRestaurant: \(String(describing: self?.filterNameForRestaurant))")
//            })
//            .store(in: &bag)
//    }
    
//    func getImageFromId(restaurantId: String) -> AnyPublisher<UIImage, Error> {
//        if let cachedImage = self.cachedImages[restaurantId] {
//            return cachedImage
//        }
//
//        return UIImage(named: "star_icon")!

// @Published var restaurants: [Restaurant] = []

// @Published var filters: [Filter] = []

// @Published var filterNameForRestaurant: [String:[String]] = [:]

// private var networkHandler = RestaurantsNetworkHandler()

// private var filtersWithoutDuplicates: [String] = []
