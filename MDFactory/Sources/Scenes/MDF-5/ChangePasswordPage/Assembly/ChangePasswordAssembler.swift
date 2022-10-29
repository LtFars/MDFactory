//
//  ChangePasswordAssembler.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 27.10.2022.
//

import UIKit

final class ChangePasswordAssembly {
    static func createChangePasswordModule() -> UIViewController {

        let view = ChangePasswordViewController()
        let presenter = ChangePasswordPresenter(view: view)
        view.presenter = presenter

        return view
    }
}
