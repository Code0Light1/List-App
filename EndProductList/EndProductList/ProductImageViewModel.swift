//
//  ProductImageViewModel.swift
//  EndProductList
//
//  Created by kiranjith on 13/03/2022.
//

import Foundation
import UIKit


class ProductImageViewModel {
    private var imageUrl: String
    private var imageRequest: ImageRequest?
    private(set) var image: Box<UIImage> = .init(UIImage())
     var failMessage: Box<String>?
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    func loadImage() {
        guard let url  =  URL(string: imageUrl) else {
            return
        }
        let imageRequest = ImageRequest(url: url)
        self.imageRequest = imageRequest
        imageRequest.execute { [weak self] result in
            switch result {
            case .success(let image):
                self?.image.value = image!
            case .failure(let error):
                self?.failMessage?.value = error.description()
            }
            
        }
    }
}
