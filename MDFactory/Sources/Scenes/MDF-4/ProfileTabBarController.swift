//
//  ProfileTabBarController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit

class ProfileTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupProfileView()
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.8470588235)
    }
    
    private func setupProfileView() {
        viewControllers =  [generateBarController(title: "Profile", image: UIImage(systemName: "person"))
        ]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabButton()
    }
    
    private func generateBarController(title: String, image: UIImage?) -> UIViewController {
        let tabBarViewController = UINavigationController()
    
        tabBarViewController.tabBarItem.title = title
        tabBarViewController.tabBarItem.image = image
        tabBarViewController.navigationBar.isHidden = true

        return tabBarViewController
    }
    
    func showMyViewControllerInACustomizedSheet() {
        
        let viewControllerToPresent = ProfileViewController()
        
        viewControllerToPresent.preferredSheetCornerRadius = 40
        viewControllerToPresent.preferredSheetSizing = .large
        
        present(viewControllerToPresent, animated: true, completion: nil)
   
    }
    
private func tabButton() {

        showMyViewControllerInACustomizedSheet()
    }
}

