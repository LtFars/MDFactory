//
//  MainTabBarController.swift
//  MDFactory
//
//  Created by Vadim Kim on 10.10.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Properties

    private var mainViewController: UIViewController?
    private var profileViewController: UIViewController?
    private var settingsViewController: UIViewController?
    private var testViewController: UIViewController?



    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupView()
    }

    // MARK: - Settings -
    
    private func setupHierarchy() {
        setupViewControllers()

        let viewControllers = [
            mainViewController,
            profileViewController,
            settingsViewController,
//            testViewController
        ]

        self.viewControllers = viewControllers.map {
            UINavigationController(rootViewController: $0 ?? UIViewController())
        }
    }

    private func setupView() {
        setupTabBarAppearance()
        tabBar.tintColor = Colors.customPurple
    }

    // MARK: - Private functions -

    private func setupViewControllers() {
        mainViewController = UIViewController()
        mainViewController?.setupTabBar(title: "Главная",
                                        imageName: "circle.grid.cross",
                                        selectedImageName: "circle.grid.cross.fill",
                                        tag: 0)

        profileViewController = ProfileScreenAssembly.assembly()
        profileViewController?.setupTabBar(title: "Профиль",
                                           imageName: "person",
                                           selectedImageName: "person.fill",
                                           tag: 1)

        settingsViewController = SettingModuleAssembly.createSettingPageModule()
        settingsViewController?.setupTabBar(title: "Настройки",
                                            imageName: "gearshape",
                                            selectedImageName: "gearshape.fill",
                                            tag: 2)
//
//        testViewController = TestViewController()
//        testViewController?.setupTabBar(title: "FB test",
//                                            imageName: "gearshape",
//                                            selectedImageName: "gearshape.fill",
//                                            tag: 3)
    }

    private func setupTabBarAppearance() {
        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
    }
}

// MARK: - Colors

extension MainTabBarController {
    enum Colors {
        static let customPurple = UIColor(hue: 252/360, saturation: 0.79, brightness: 1, alpha: 1)
    }
}
