//
//  ProductImageViewModel.swift
//  EndProductList
//
//  Created by kiranjith on 15/03/2022.
//


import Foundation
struct ImagesViewModel {
    
    private(set) var failMessage: Box<String>?
    weak var service: ProductsServiceProtocol?
    private(set) var products: Box<[Product]> = .init([])
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: ProductsServiceProtocol = ProductsService.shared) {
        self.service = service
    }
    
    func fetchProducts() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetchProducts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products) :
                    self.products.value.append(contentsOf: products)
                    
                case .failure(let error) :
                    self.failMessage?.value = error.description()
                }
            }
        }
    }
}
