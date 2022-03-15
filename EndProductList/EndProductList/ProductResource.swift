//
//  ProductResource.swift
//  EndProductList
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation


// MARK: - ProductResource
class ProductResource: APIResource {
    typealias ModelType = Product
    var id: Int?
    
    var methodPath: String {
        guard let id = id else {
            return "/media/catalog/example.json"
        }
        return "/media/catalog/example.json/\(id)"
    }
    
    var filter: String? {
        id != nil ? "" : nil
    }
}
