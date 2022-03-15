//
//  RequestService.swift
//  TemplateProject
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation

final class RequestService {
    
    // todo add model
    func loadData(urlString: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data, ErrorResult>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: "Wrong url format")))
            return nil
        }
        
        let request = RequestFactory.request(method: .GET, url: url)
            
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.network(string: "An error occured during request :" + error.localizedDescription)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        return task
    }
}


