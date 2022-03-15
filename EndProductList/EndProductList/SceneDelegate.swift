//
//  SceneDelegate.swift
//  EndProductList
//
//  Created by kiranjith on 10/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        let coordinator = AppCoordinator(window: window)
        self.coordinator = coordinator
        coordinator.start()
        
    }

}

