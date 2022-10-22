//
//  ChangePasswordSettingPageViewController.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 22.10.2022.
//

import UIKit

class ChangePasswordSettingPageViewController: UIViewController {

    private lazy var passwordTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Новый пароль")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.next
        textField.tag = 0
        return textField
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
    }

    private func setupView() {

        view.backgroundColor = .systemGray6
        navigationItem.title = "Изменить пароль"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(passwordTextField)
    }

    private func setupLayout() {
        passwordTextField.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
//            make.leading.trailing.equalTo(view).inset(20)
            make.height.equalTo(58 * UIScreen.main.bounds.height / 812)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.trailing.equalTo(view).inset(20)
        }
    }
}
