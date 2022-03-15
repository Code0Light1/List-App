//
//  RequestService.swift
//  TemplateProject
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation

///A factory for the request method 
final class RequestFactory {
    
    enum Method: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    static func request(method: Method, url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
