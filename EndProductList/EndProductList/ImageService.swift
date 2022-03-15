//
//  ImageRequest.swift
//  EndProductList
//
//  Created by kiranjith on 13/03/2022.
//

import Foundation
import UIKit

// MARK: - ImageRequest


fileprivate var imageCache =  NSCache<NSString, UIImage>()
protocol ImageService {
    func loadImage(_ url: URL, withCompletion completion: @escaping (Result<UIImage?, ErrorResult>) -> Void)
}
class ImageRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

extension ImageRequest: ImageService {
    
    func loadImage(_ url: URL, withCompletion completion: @escaping (Result<UIImage?, ErrorResult>) -> Void) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async { completion(.success(image)) }
        } else {
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
                guard let data = data, let value = self?.decode(data) else {
                    DispatchQueue.main.async { completion(.failure(.parser(string: "parse error"))) }
                    return
                }
                imageCache.setObject(value, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(.success(value)) }
            }
            
            task.resume()
        }
        
    }
    func execute(withCompletion completion: @escaping (Result<UIImage?, ErrorResult>) -> Void) {
        loadImage(url, withCompletion: completion)
    }
    
    func decode(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    
}
