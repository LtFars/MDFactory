//
//  ChangePasswordPresenter.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 27.10.2022.
//

import Foundation

protocol ChangePasswordPresenterType: AnyObject {
    func checkCurrentPassword(currentPassword: String) -> Bool
    func updatePassword(to newPassword: String)
}

final class ChangePasswordPresenter {

    private weak var view: ChangePasswordViewControllerType?

    init(view: ChangePasswordViewControllerType) {
        self.view = view
    }
}

extension ChangePasswordPresenter: ChangePasswordPresenterType {
    func checkCurrentPassword(currentPassword: String) -> Bool {
        let login = FirebaseService().userName
        print("get user name: \(login) from FB")
        var storedPassword = String()
        do {
            storedPassword = try SecureStorage.readPassword(userName: login)
            print("get storedPassword: \(storedPassword) from FB")
        } catch {
            print("\(error)")
        }
        if currentPassword == storedPassword {
            return true
        }
        return false
    }

    func updatePassword(to newPassword: String) {
        print("Password updated to: \(newPassword)")

        FirebaseService().updatePassword(to: newPassword) { [weak self] result in
            switch result {
            case .success(_):
                let userName = FirebaseService().userName
                do {
                    try SecureStorage.updatePassword(userName: userName, to: newPassword)
                    print("new password \(newPassword) for \(userName) has been saved")
                } catch {
                    print("saving password \(error)")
                }
                self?.view?.updatePasswordSucceeded()
            case .failure(let error):
                self?.view?.updatePasswordFailed(message: "\(error.localizedDescription)")
            }
        }
    }
}
