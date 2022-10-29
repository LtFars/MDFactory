//
//  SettingPageAssembly.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import UIKit

class SettingPageAssembly {
    static func createSettingPageModule() -> UIViewController {
        let view = SettingPageViewController()
        let user = User.fetchData
        let presenter = SettingPagePresenter(view: view, user: user)
        view.presenter = presenter

        return view
    }
}
