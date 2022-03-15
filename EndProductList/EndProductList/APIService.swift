//
//  APIService.swift
//  EndProductList
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation


// MARK: - APIResource
protocol APIResource {
    associatedtype ModelType: Decodable
    var methodPath: String { get }
    var filter: String? { get }
}

extension APIResource {
    var url: URL {
        var components = URLComponents(string: "https://www.endclothing.com")!
        components.path = methodPath
        if let filter = filter {
            components.queryItems?.append(URLQueryItem(name: "filter", value: filter))
        }
        return components.url!
    }
}

// MARK: - APIRequest
class APIRequest<Resource: APIResource> {
    let resource: Resource
    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequest {
    
    func decode(_ data: Data) -> [Resource.ModelType]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
      //  let wrapper = try? decoder.decode(Wrapper<Resource.ModelType>.self, from: data)
        return []
    }
    
    func execute(withCompletion completion: @escaping (Result<[Resource.ModelType]?, ErrorResult>) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}
