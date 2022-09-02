//
//  ProfileTabBarController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit

class ProfileTabBarController: UITabBarController {
    
//    let profilController = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
        setupProfileView()
    }

    private func setupProfileView() {
        viewControllers =  [generateNavigationController(title: "Profile", image: UIImage(systemName: "person"))
        ]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        tabButton()
    }
    
    private func generateNavigationController(title: String, image: UIImage?) -> UIViewController {
        let navigationViewController = UINavigationController()
        
        navigationViewController.tabBarItem.title = title
        navigationViewController.tabBarItem.image = image
        return navigationViewController
    }
    
    //UISheetPresentationController
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

