//
//  ProfileScreenAssembly.swift
//  MDFactory
//
//  Created by Andrei Maskal on 18/10/2022.
//

import UIKit

class ProfileScreenAssembly {
    static func assembly() -> UIViewController {
        
        let profileViewController = ProfileViewController()
        let profileScreenPresenter = ProfileScreenPresenter(view: profileViewController)
        profileViewController.presenter = profileScreenPresenter
        return profileViewController
    }
}
