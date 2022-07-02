//
//  ImageCacheService.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 29.01.2022.
//

import UIKit

protocol ImageCacheServiceProtocol {
    func getCashedImage(url: String) -> UIImage?
    func setCashedImage(image: UIImage, url: String)
}

class ImageCacheService: ImageCacheServiceProtocol {
    private let imageCache = NSCache<NSString, UIImage>()
    
    static let shared: ImageCacheService = {
        let instance = ImageCacheService()
        return instance
    }()
    
    private init() {}
    
    func getCashedImage(url: String) -> UIImage? {
        return imageCache.object(forKey: url as NSString)
    }
    
    func setCashedImage(image: UIImage, url: String) {
        self.imageCache.setObject(image, forKey: url as NSString)
    }
}
