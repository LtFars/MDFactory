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

    /// Present UIAlertController with "OK" button
    func showAlert(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }

    func showDeleteAlert(with title: String, message: String, alertAction: @escaping (UIAlertAction) -> () ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: alertAction))
        alertController.addAction(UIAlertAction(title: "Отменить", style: .default))
        self.present(alertController, animated: true)
    }
}
