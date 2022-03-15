//
//  AppCoordinator.swift
//  CryptoFace
//
//  Created by kiranjith on 08/03/2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get }
    func start()
}

final class AppCoordinator: Coordinator {
    private(set) var childCoordinator: [Coordinator] = []
    let window: UIWindow!
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        let loginCoordinator = ProductListCoordinator(navigationController: navigationController)
        childCoordinator.append(loginCoordinator)
        loginCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
