//
//  UIViewController+Ext.swift
//  MDFactory
//
//  Created by Vadim Kim on 10.10.2022.
//

import UIKit

extension UIViewController {
    func setupTabBar(title: String, imageName: String, selectedImageName: String, tag: Int) {
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: imageName), tag: tag)
        self.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        self.view.backgroundColor = .systemBackground
    }
}
