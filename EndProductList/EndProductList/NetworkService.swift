//
//  Network.swift
//  EndProductList
//
//  Created by kiranjith on 12/03/2022.
//

import Foundation
import UIKit


enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
    
    func description() -> String {
        return self.localizedDescription
    }
}
// MARK: - NetworkRequest
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    func execute(withCompletion completion: @escaping (Result<ModelType?, ErrorResult>) -> Void)
    func decode(_ data: Data) -> ModelType?
}

extension NetworkRequest {
     func load(_ url: URL, withCompletion completion: @escaping (Result<ModelType?, ErrorResult>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _ , _) -> Void in
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(.network(string: "network error"))) }
                return
            }
            if  let value = self?.decode(data) {
                DispatchQueue.main.async { completion(.success(value)) }
            } else {
                DispatchQueue.main.async { completion(.failure(.parser(string: "parse error"))) }
            }
          
        }
        task.resume()
    }
}


