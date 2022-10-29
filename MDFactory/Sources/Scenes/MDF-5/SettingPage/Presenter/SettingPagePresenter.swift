//
//  SettingPagePresenter.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import Foundation

protocol SettingPagePresenterType: AnyObject {

    init(view: SettingPageViewControllerType, user: User)

    func updatePassword()
    func logout()
    func deleteUser()
    func getUser()
}

final class SettingPagePresenter: SettingPagePresenterType {

    private weak var view: SettingPageViewControllerType?
    private var user: User

    required init(view: SettingPageViewControllerType, user: User) {
        self.view = view
        self.user = user
    }

    // MARK: - SettingPagePresenter Methods

extension SettingPagePresenter: SettingPagePresenterType {
    func getUser() {
//        let avatar = user.avatar ?? "moon"
        view?.setUser(avatar: user.avatar,
                      name: user.name,
                      surname: user.surname,
                      email: user.email)
    }

    func updatePassword() {
        let vc = SettingModuleAssembly.createChangePasswordModule()
        view?.pushUpdatePassordScreen(to: vc)
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
