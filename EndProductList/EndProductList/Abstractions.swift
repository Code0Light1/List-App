//
//  Abstractions.swift
//  EndProductList
//
//  Created by kiranjith on 11/03/2022.
//

import Foundation

protocol Listable {
    associatedtype ListableItem: Hashable
    func listItem(_ item: ListableItem)
}
