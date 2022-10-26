//
//  ChangePasswordSettingPageViewController.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import UIKit

class ChangePasswordSettingPageViewController: UIViewController {

    // MARK: - Private Properties

    private lazy var passwordTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Новый пароль")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.next
        textField.tag = 0
        return textField
    }()

    private lazy var passwordAgainTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Новый пароль ещё раз")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.next
        textField.tag = 0
        return textField
    }()

    private lazy var changePasswordButton: UIButton = {
        let button = MainCustomButton(cornerRadius: 16 * UIScreen.main.bounds.height / 812)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
        stack.spacing = 20
        return stack
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }

    @objc private func backAction() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func changePasswordButtonTapped() {
        guard !passwordTextField.text!.isEmpty, !passwordAgainTextField.text!.isEmpty else {
print("is Empty")
            return }

        guard passwordAgainTextField.text == passwordTextField.text else {
            print("password not equatable")
            return }
        print("ch Pssw")
    }

    private func setupView() {

        view.backgroundColor = .systemGray6
        navigationItem.title = "Изменить пароль"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        view.addSubview(buttonStack)

        let buttonStackSubview = [
            passwordTextField,
            passwordAgainTextField,
            changePasswordButton
        ]

        buttonStackSubview.forEach {
            buttonStack.addArrangedSubview($0)
        }
    }

    private func setupLayout() {
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(58 * UIScreen.main.bounds.height / 812)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalTo(view).inset(20)
        }
    }
}
