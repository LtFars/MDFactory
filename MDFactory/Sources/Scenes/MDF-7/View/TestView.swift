//
//  TestView.swift
//  MDFactory
//
//  Created by Vadim Kim on 12.10.2022.
//

import UIKit
import SnapKit

class TestView: UIView {

    // MARK: - Properties

    lazy var logOutButton = createFunctionalButton(title: "Выйти из аккаунта")
    lazy var deleteUserButton = createFunctionalButton(title: "Удалить аккаунт")
    lazy var updatePasswordButton = createFunctionalButton(title: "Обновить пароль")
    lazy var resetPasswordButton = createFunctionalButton(title: "Восстановить пароль")

    lazy var updatePasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите новый пароль"
        textField.borderStyle = .roundedRect
        return textField
    }()

    // MARK: - Initial

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        setupHierarchy()
        setupLayout()
        setupView()
    }

    // MARK: - Settings

    private func setupHierarchy() {
        let subviews = [
            logOutButton,
            deleteUserButton,
            updatePasswordButton,
            updatePasswordTextField,
            resetPasswordButton
        ]
        subviews.forEach { addSubview($0) }
    }

    private func setupLayout() {
        logOutButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(Metrics.defaultTopOffset)
        }

        deleteUserButton.snp.makeConstraints { make in
            make.centerX.equalTo(logOutButton)
            make.top.equalTo(logOutButton).offset(Metrics.defaultTopOffset)
        }

        updatePasswordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(logOutButton)
            make.top.equalTo(deleteUserButton).offset(Metrics.defaultTopOffset)
        }

        updatePasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(logOutButton)
            make.top.equalTo(updatePasswordTextField).offset(Metrics.defaultTopOffset)
        }

        resetPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(logOutButton)
            make.top.equalTo(updatePasswordButton).offset(Metrics.defaultTopOffset)
        }

    }

    private func setupView() {
        backgroundColor = .systemBackground
    }
}


// MARK: - Metrics

extension TestView {
    enum Metrics {
        static let defaultTopOffset = 50
    }
}

// MARK: - Create button

extension TestView {
    func createFunctionalButton(title: String) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.buttonSize = .medium
        configuration.cornerStyle = .medium
        configuration.title = title
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        button.configuration = configuration
        return button
    }
}
