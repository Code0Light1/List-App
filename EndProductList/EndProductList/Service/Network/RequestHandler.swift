//
//  RequestService.swift
//  TemplateProject
//
//  Created by kiranjith on 15/03/2022.
//


import Foundation
import UIKit
///Handles the response data 
class RequestHandler {
    
    func networkResult(completion: @escaping ((Result<[Product], ErrorResult>) -> Void)) ->
    ((Result<Data, ErrorResult>) -> Void) {
        
        return { dataResult in
            
            DispatchQueue.global(qos: .background).async(execute: {
                switch dataResult {
                case .success(let data) :
                    if let data = ParserHelper.decode(data) {
                        completion(.success(data))
                    } else {
                        completion(.failure(.network(string: "Parse error ")))
                    }
                    
                    break
                case .failure(let error) :
                    print("Network error \(error)")
                    completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                    break
                }
            })
            
        }
    }
}



