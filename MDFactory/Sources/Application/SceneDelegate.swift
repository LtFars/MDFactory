//
//  SceneDelegate.swift
//  MDFactory
//
//  Created by Denis Snezhko on 27.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var rootViewController: UIViewController = FirstPageViewController()
    private var isNetworkAvailable = false

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        userAutoLogin()

        let navigationController = UINavigationController(rootViewController: rootViewController)
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window

    }
}

extension SceneDelegate {

    private func userAutoLogin() {
        do {
            let login = FirebaseService().userName
            if try SecureStorage.isExists(userName: login) {
                let password = try SecureStorage.readPassword(userName: login)
                print("autoLogin user found with: \(login), password \(password)")
                rootViewController = MainTabBarController()

                DispatchQueue.global().async {
                    repeat {
                        self.firebaseSingInCheck(login: login, password: password)
                      sleep(300)
                    } while !self.isNetworkAvailable
                }
            } else {
                print("No user data in keychain")
            }
        } catch {
            print(error)
        }
    }

    private func firebaseSingInCheck(login: String, password: String) {
        FirebaseService().signIn(email: login, password: password) { [weak self] result in
            switch result {
            case .success:
                print("Success sign in Firebase with: \(login)")
                self?.isNetworkAvailable = true
                break
            case .failure(let error):
                switch error {
                case .networkError:
                    print(error.localizedDescription)
                default:
                    print("Fail sign in Firebase due to: \(error.localizedDescription)")
                    let rootViewController = FirstPageViewController()
                    let navigationController = UINavigationController(rootViewController: rootViewController)
                    self?.window?.switchRootViewController(to: navigationController)
                    self?.isNetworkAvailable = true
                    break
                }
            }
        }
    }
}
