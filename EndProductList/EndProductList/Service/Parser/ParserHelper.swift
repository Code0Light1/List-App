//
//  RequestService.swift
//  TemplateProject
//
//  Created by kiranjith on 15/03/2022.
//


import Foundation

final class ParserHelper {
    
   static func decode(_ data: Data) -> [Product]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
       let wrapper = try? decoder.decode(Wrapper.self, from: data)
        return wrapper?.products
    }
}
