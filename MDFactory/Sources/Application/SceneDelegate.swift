//
//  SceneDelegate.swift
//  MDFactory
//
//  Created by Denis Snezhko on 27.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
       let navigationController = UINavigationController(rootViewController: FirstPageViewController())
//        let navigationController = UINavigationController(rootViewController: MainTabBarController())
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

