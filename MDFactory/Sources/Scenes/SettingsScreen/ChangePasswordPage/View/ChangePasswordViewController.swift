//
//  ChangePasswordViewController.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import UIKit

protocol ChangePasswordViewControllerType: AnyObject {
    func updatePasswordSucceeded()
    func updatePasswordFailed(message: String)
}

class ChangePasswordViewController: UIViewController {

    var presenter: ChangePasswordPresenterType?

    // MARK: - Elements

    private lazy var currentPasswordTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Текуший пароль", secureTextMode: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()
    
    private lazy var newPasswordTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Новый пароль", secureTextMode: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()

    private lazy var newPasswordAgainTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Новый пароль ещё раз", secureTextMode: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.go
        return textField
    }()

    private lazy var changePasswordButton: UIButton = {
        let button = MainCustomButton(cornerRadius: SettingModuleMetrics.buttonCornerRadius)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: SettingModuleMetrics.buttonFontSize)
        button.setTitle("изменить пароль", for: .normal)
        button.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "back")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = SettingModuleMetrics.buttonStackSpacing
        return stack
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }

// MARK: - SetupView

    private func setupView() {

        view.backgroundColor = .systemBackground
        navigationItem.title = "Изменить пароль"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(buttonStack)

        let buttonStackSubview = [
            currentPasswordTextField,
            newPasswordTextField,
            newPasswordAgainTextField,
            changePasswordButton
        ]

        buttonStackSubview.forEach {
            buttonStack.addArrangedSubview($0)
        }
    }

    // MARK: - Setup Layout

    private func setupLayout() {
        newPasswordTextField.snp.makeConstraints { make in
            make.height.equalTo(SettingModuleMetrics.buttonHeight)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(
                SettingModuleMetrics.buttonStackLeadingTrailingOffset)
            make.leading.trailing.equalTo(view).inset(
                SettingModuleMetrics.buttonStackLeadingTrailingOffset)
        }
    }

    // MARK: - Actions

    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func changePasswordButtonTapped() {
        guard let currentPassword = currentPasswordTextField.text, !currentPassword.isEmpty,
              newPasswordTextField.text?.isEmpty == false,
              newPasswordAgainTextField.text?.isEmpty == false else {
            print("is Empty")
            return }

        guard ((presenter?.checkCurrentPassword(currentPassword: currentPassword)) != false) else {
            print("current and stored passwords are not equal")
            showAlert(withTitle: "Неверный текущий пароль", message: "Попробуйте ещё раз")
            return
        }

        guard newPasswordAgainTextField.text == newPasswordTextField.text else {
            showAlert(withTitle: "Новый пароль не совпадает", message: "Попробуйте ещё раз")
            print("new passwords are not equal")
            return }

        if let newPassword = newPasswordTextField.text {
            presenter?.updatePassword(to: newPassword)
        }
    }
}

// MARK: - ChangePasswordViewController Methods

extension ChangePasswordViewController: ChangePasswordViewControllerType {
    func updatePasswordSucceeded() {
        CATransaction.begin()
        navigationController?.popViewController(animated: true)
        CATransaction.setCompletionBlock({ [weak self] in
            guard let self = self else { return }
            self.showAlert(withTitle: "Пароль упешно изменен", message: "")
                })
        CATransaction.commit()
    }

    func updatePasswordFailed(message: String) {
        showAlert(withTitle: "Ошибка", message: message)
    }
}
