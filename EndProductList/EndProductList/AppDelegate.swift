//
//  AppDelegate.swift
//  EndProductList
//
//  Created by kiranjith on 10/03/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UILabel.appearance().font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: "Helvetica Neue"))
        return true
    }
}

