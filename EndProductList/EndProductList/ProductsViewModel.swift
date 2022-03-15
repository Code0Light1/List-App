//
//  ProductsViewModel.swift
//  EndProductList
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation
struct ProductsViewModel {
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    weak var service: ProductsServiceProtocol?
    
    /// Boxing  used to bind the values to the controller. Protocols can also be used for the same.
    private(set) var products: Box<[Product]> = .init([])

    
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
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
