//
//  RestaurantsImageCaching.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import UIKit
import Combine

class ImageCacher {
    
    @Published var imageCache = [NSCache<AnyObject, AnyObject>]()
    
    var subscription: AnyCancellable?
    
    
    init() {
        
    }
    
    deinit {
        
    }
    
    
    func cacheImage(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
//            .ass
    }
}
