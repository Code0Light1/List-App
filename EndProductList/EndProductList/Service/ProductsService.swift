//
//  RequestService.swift
//  TemplateProject
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation
/// Abstraction used to remove any tight coupling
protocol ProductsServiceProtocol : AnyObject {
    func fetchProducts(_ completion: @escaping ((Result<[Product], ErrorResult>) -> Void))
}

final class ProductsService : RequestHandler, ProductsServiceProtocol {
    static let shared = ProductsService()
    let endpoint = "https://www.endclothing.com/media/catalog/example.json"
    var task : URLSessionTask?
    func fetchProducts(_ completion: @escaping ((Result<[Product], ErrorResult>) -> Void)) {
        self.cancelFetchProducts()
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchProducts() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}

