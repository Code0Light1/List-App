//
//  Product.swift
//  EndProductList
//
//  Created by kiranjith on 11/03/2022.
//

import Foundation

struct Product : Hashable, Decodable {
   
    
    let image: String
    let name: String
    let price: String
    let id: String
    let identifier = UUID()
    
    private enum CodingKeys : String, CodingKey {
        case image, name, price, id
    }
    
}


struct Wrapper: Decodable {
    let products: [Product]
    let title: String
    let productCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case productCount = "product_count"
        case title
        case products
    }
}
