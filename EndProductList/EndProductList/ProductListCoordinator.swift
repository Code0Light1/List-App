//
//  ProductListCoordinator.swift
//  EndProductList
//
//  Created by kiranjith on 10/03/2022.
//

import Foundation
import UIKit


class ProductListCoordinator: Coordinator {
    private(set)  var childCoordinator: [Coordinator] = []
    private  var navigationController: UINavigationController
    weak var delegate: BackToRootViewDelegate?
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let viewController = ProductListController()
        viewController.delegate = self
        self.navigationController.setViewControllers([viewController], animated: true)
    }
}


extension ProductListCoordinator: ProductListControllerDelegate {
    // Navigate to next page
    func navigateToNextPage(withProduct product: Product) {
        let secondCoordinator = ProductDetailCoordinator(navigationController: navigationController, data: product)
        secondCoordinator.delegate = self
        childCoordinator.append(secondCoordinator)
        secondCoordinator.start()
    }
}

extension ProductListCoordinator: BackToRootViewDelegate {
    func navigateBackToFirstPage(newOrderCoordinator: ProductDetailCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinator.removeLast()
    }
    
}
