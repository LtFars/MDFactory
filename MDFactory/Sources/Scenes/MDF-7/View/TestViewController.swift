//
//  TestViewController.swift
//  MDFactory
//
//  Created by Vadim Kim on 12.10.2022.
//

import UIKit

class TestViewController: UIViewController {

    // MARK: - Properties

    private var testView: TestView? {
        guard isViewLoaded else { return nil }
        return view as? TestView
    }

    // MARK: - Lifecycle

    override func loadView() {
        view = TestView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addActionsForButtons()
    }

    // MARK: - Private functions

    private func addActionsForButtons() {
        testView?.logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        testView?.deleteUserButton.addTarget(self, action: #selector(deleteUserButtonTapped), for: .touchUpInside)
        testView?.updatePasswordButton.addTarget(self, action: #selector(updatePasswordButtonTapped), for: .touchUpInside)
        testView?.resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
    }

}

// MARK: - Actions for buttons

extension TestViewController {
    @objc private func logOutButtonTapped() {
        FirebaseService().logOut { [weak self] result in
            switch result {
            case .success(_):
                guard let window = self?.view.window else { return }
                window.switchRootViewController(to: UINavigationController(rootViewController: FirstPageViewController()))
            case .failure(let error):
                self?.showAlert(withTitle: "Ошибка", message: "\(error.localizedDescription)")
            }
        }
    }

    @objc private func deleteUserButtonTapped() {
        FirebaseService().deleteUser { [weak self] result in
            switch result {
            case .success(_):
                print("\nПользователь удален\n")
                guard let window = self?.view.window else { return }
                window.switchRootViewController(to: UINavigationController(rootViewController: FirstPageViewController()))
            case .failure(let error):
                self?.showAlert(withTitle: "Ошибка", message: "\(error.localizedDescription)")
            }
        }
    }

    @objc private func updatePasswordButtonTapped() {
        guard let password = testView?.updatePasswordTextField.text, !password.isEmpty
        else {
            showAlert(withTitle: "Ошибка", message: "Заполнены не все поля.")
            return
        }

        FirebaseService().updatePassword(to: password) { [weak self] result in
            switch result {
            case .success(_):
                self?.showAlert(withTitle: "Пароль упешно изменен", message: "")
            case .failure(let error):
                self?.showAlert(withTitle: "Ошибка", message: "\(error.localizedDescription)")
            }
        }
    }

    @objc private func resetPasswordButtonTapped() {
        FirebaseService().sendMessageToResetPassword { [weak self] result in
            switch result {
            case .success(_):
                self?.showAlert(withTitle: "Подтверждение для сброса пароля отправлено на эл. почту", message: "")
            case .failure(let error):
                self?.showAlert(withTitle: "Ошибка", message: "\(error.localizedDescription)")
            }
        }
    }

}
