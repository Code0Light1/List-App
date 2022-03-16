//
//  ProductDetailCoordinator.swift
//  EndProductList
//
//  Created by kiranjith on 10/03/2022.
//

import Foundation
import UIKit


protocol BackToRootViewDelegate: AnyObject {
    func navigateBackToFirstPage(newOrderCoordinator: ProductDetailCoordinator)
}

class ProductDetailCoordinator: Coordinator {
    private(set)  var childCoordinator: [Coordinator] = []
    private  var navigationController: UINavigationController
    private var product: Product
    weak var delegate: BackToRootViewDelegate?
    init(navigationController: UINavigationController, data: Product) {
        self.navigationController = navigationController
        
        self.product = data
    }
    func start() {
        let viewController = ProductDetailController(product: product)
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension ProductDetailCoordinator : ProductDetailControllerDelegate {
    // Navigate to first page
    func navigateToFirstPage() {
        self.delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
}


