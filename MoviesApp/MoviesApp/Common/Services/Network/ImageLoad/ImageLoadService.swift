//
//  ImageLoadService.swift
//  MoviesApp
//
//  Created by Sergey Stelmakh on 29.01.2022.
//

import UIKit

protocol ImageLoadServiceProtocol {
    /// получить картинку по УРЛу (картинка? прилетает в замыкание)
    func getImageFrom(_ urlString: String, completion: @escaping (UIImage?) -> Void)
}

final class ImageLoadService: ImageLoadServiceProtocol {
    static var shared: ImageLoadServiceProtocol = {
        let instance = ImageLoadService()
        return instance
    }()
    
    
    private init() {}

    private func downloadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let handler: (Data?, URLResponse?, Error?) -> Void = { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { completion(nil)
                return }
            completion(image)
        }
    
        URLSession.shared.dataTask(with: url, completionHandler: handler).resume()
    }
    
    func getImageFrom(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        downloadImage(urlString: urlString, completion: completion)
    }
}
