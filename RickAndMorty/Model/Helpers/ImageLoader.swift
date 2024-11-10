//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 09.11.2024.
//

import UIKit
import Dependencies
import Nuke

class ImageLoader {
    
    private let pipeline: ImagePipeline
    
    init() {
        self.pipeline = ImagePipeline { config in
            config.dataCache = try? DataCache(name: "RickAndMorty.ImageCache")
            config.imageCache = ImageCache.shared
            
        }
    }
    
    func loadImage(from url: URL) async -> UIImage? {
        return await withCheckedContinuation { continuation in
            self.pipeline.loadImage(with: url) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response.image)
                    break
                case .failure(_):
                    continuation.resume(returning: nil)
                }
            }
        }
    }
    
}


extension ImageLoader: DependencyKey {
    static let liveValue = ImageLoader()
}


extension DependencyValues {
    var imageLoader: ImageLoader {
        get { self[ImageLoader.self] }
        set { self[ImageLoader.self] = newValue }
    }
}
