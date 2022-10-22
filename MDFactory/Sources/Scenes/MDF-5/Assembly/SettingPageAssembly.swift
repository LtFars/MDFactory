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
        let presenter = SettingPagePresenter(view: view)
        view.presenter = presenter

        return view
    }
}
