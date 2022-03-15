//
//  RequestService.swift
//  TemplateProject
//
//  Created by kiranjith on 15/03/2022.
//

import Foundation

enum ErrorResult: Error {
    case network(string: String)
    case parser(string: String)
    case custom(string: String)
    
    var description: String {
        return self.localizedDescription
    }
}
