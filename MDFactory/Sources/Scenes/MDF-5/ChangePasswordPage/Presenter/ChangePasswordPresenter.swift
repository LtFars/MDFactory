//
//  ChangePasswordPresenter.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 27.10.2022.
//

import Foundation

protocol ChangePasswordPresenterType: AnyObject {
    func updatePassword(to newPassword: String)
}

final class ChangePasswordPresenter {

    private weak var view: ChangePasswordViewControllerType?

    init(view: ChangePasswordViewControllerType) {
        self.view = view
    }
}

extension ChangePasswordPresenter: ChangePasswordPresenterType {
    func updatePassword(to newPassword: String) {
        print("Password updated to: \(newPassword)")

        FirebaseService().updatePassword(to: newPassword) { [weak self] result in
            switch result {
            case .success(_):
                self?.view?.updatePasswordSucceeded()
            case .failure(let error):
                self?.view?.updatePasswordFailed(message: "\(error.localizedDescription)")
            }
        }
    }
}
