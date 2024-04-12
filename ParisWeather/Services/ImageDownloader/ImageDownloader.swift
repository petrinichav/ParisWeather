//
//  ImageDownloader.swift
//  ParisWeather
//
//  Created by Aliaksei Piatrynich on 11/04/2024.
//

import UIKit
import RxSwift
import RxCocoa

final private class ImageCache {
    private var images = [String: UIImage]()
    private var paths = [String]()
    private let capacity: Int
    
    init(capacity: Int) {
        self.capacity = capacity
    }
    
    func image(for path: String) -> UIImage? {
        return images[path]
    }
    
    func insertImage(_ image: UIImage, for path: String) {
        if images.keys.contains(path) {
            return
        }
        
        images[path] = image
        paths.append(path)
        
        if path.count > capacity {
            let pathToRemove = paths.removeFirst()
            images[pathToRemove] = nil
        }
    }
}

class WeatherIconDownloader {
    private let cache = ImageCache(capacity: 10)
    
    func download(icon: String) -> Observable<UIImage>? {
        if let image = cache.image(for: icon) {
            return Observable.just(image)
        }
        
        return try? Request.weatherIcon(path: "img/wn/", icon: icon)
            .data()
            .compactMap({ [weak self] data in
                guard let image = UIImage(data: data) else {
                    return nil
                }
                self?.cache.insertImage(image, for: icon)
                return image
            })
    }
}
