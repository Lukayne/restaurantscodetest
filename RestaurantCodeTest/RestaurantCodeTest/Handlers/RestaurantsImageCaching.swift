//
//  RestaurantsImageCaching.swift
//  RestaurantCodeTest
//
//  Created by Richard Smith on 2023-11-15.
//

import Combine
import SwiftUI
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: Image?

    init(url: String) {
        loadImage(from: url)
    }

    private func loadImage(from url: String) {
        guard let url = URL(string: url) else {
            return
        }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let uiImage = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}
