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
        ]

        self.viewControllers = viewControllers.map {
            UINavigationController(rootViewController: $0 ?? UIViewController())
        }
    }

    private func setupView() {
        setupTabBarAppearance()
    }

    // MARK: - Private functions -

    private func setupViewControllers() {
        mainViewController = MainPageAssembly.assembly()
        mainViewController?.setupTabBar(title: "Главная",
                                        imageName: "circle.grid.2x2",
                                        selectedImageName: "circle.grid.2x2.fill",
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
    }

    private func setupTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let shapeLayer = CAShapeLayer()

        tabBar.layer.insertSublayer(shapeLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered

        shapeLayer.fillColor = UIColor.black.cgColor
        tabBar.tintColor = Colors.customPurple
        tabBar.unselectedItemTintColor = UIColor.lightGray

        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .semibold)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
    }
}

// MARK: - Colors

extension MainTabBarController {
    enum Colors {
        static let customPurple = UIColor(hue: 252/360, saturation: 0.79, brightness: 1, alpha: 1)
    }
}
