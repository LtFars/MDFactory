//
//  SettingPagePresenter.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import Foundation

protocol SettingPagePresenterType: AnyObject {
    var user: User { get set }
    func logout()
    func deleteUser()
}

final class SettingPagePresenter {

    private weak var view: SettingPageViewControllerType?
    var user: User

    init(view: SettingPageViewControllerType) {
        self.view = view
        self.user = User.fetchData
    }
}

// MARK: - SettingPagePresenter Methods

extension SettingPagePresenter: SettingPagePresenterType {

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
