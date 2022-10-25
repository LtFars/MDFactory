//
//  SettingPagePresenter.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import Foundation

protocol SettingPagePresenterType: AnyObject {
    func updatePassword()
    func logout()
    func deleteUser()
}

final class SettingPagePresenter {

    private weak var view: SettingPageViewControllerType?

    init(view: SettingPageViewControllerType) {
        self.view = view
    }
}

extension SettingPagePresenter: SettingPagePresenterType {
    func updatePassword() {
        //
    }

    func logout() {
        FirebaseService().logOut { [weak self]result in
            switch result {
            case .success(_):
                self?.view?.logoutSucceeded()
            case .failure(let error):
                self?.view?.logoutFailed(message: "\(error.localizedDescription)")
            }
        }
    }

    func deleteUser() {
        FirebaseService().deleteUser { [weak self] result in
            switch result {
            case .success(_):
                print("\nПользователь удален\n")
                self?.view?.logoutSucceeded()
            case .failure(let error):
                self?.view?.logoutFailed(message: "\(error.localizedDescription)")
            }
        }
    }
}
