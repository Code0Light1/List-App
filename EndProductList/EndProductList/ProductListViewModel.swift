//
//  ProductViewModel.swift
//  EndProductList
//
//  Created by kiranjith on 11/03/2022.
//

import UIKit


final class ProductListViewModel {
    
    private var request: APIRequest<ProductResource>
    private(set) var products: Box<[Product]> = .init([])
    private(set) var failMessage: Box<String>?
    private var resource: ProductResource
   
    init(with service: APIRequest<ProductResource>) {
        self.request = service
        self.resource = service.resource
    }
     func fetchProducts() {
        request.execute(withCompletion: { [weak self] result in
            switch result {
            case .success(let products):
                if let product = products{
                    self?.products.value.append(contentsOf: product)
                }
                
            case .failure(let error) :
                self?.failMessage?.value = error.description()
                
            }
            
        })
    }
}
