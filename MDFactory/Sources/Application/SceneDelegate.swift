//
//  SceneDelegate.swift
//  MDFactory
//
//  Created by Denis Snezhko on 27.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var rootVC: UIViewController = FirstPageViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let login = FirebaseService().userName
        
        do {
            if try SecureStorage.isExists(userName: login) {
                let password = try SecureStorage.readPassword(userName: login)
                print("autoLogin user: \(login), password \(password)")
                autoLogin(login: login, password: password)
            } else {
                print("No user data in keychain")
            }
        } catch {
            print(error)
        }

        let navigationController = UINavigationController(rootViewController: rootVC)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

    private func autoLogin(login: String, password: String) {
        FirebaseService().signIn(email: login, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.window?.switchRootViewController(to: MainTabBarController())
            case .failure(_):
                break
            }
        }
    }
}

