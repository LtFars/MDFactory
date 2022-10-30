//
//  SettingPageViewController.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 16.10.2022.
//

import UIKit
import SnapKit

// MARK: - SettingPageViewControllerType

protocol SettingPageViewControllerType: AnyObject {
    func pushUpdatePassordScreen(to vc: UIViewController)
    func logoutSucceeded()
    func logoutFailed(message: String)
    func setUser(avatar: String?,
                 name: String,
                 surname: String,
                 email: String)
}

// MARK: - SettingPageViewController

class SettingPageViewController: UIViewController {

    var presenter: SettingPagePresenterType?

    private lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 75
        if let userAvatar = presenter?.user.avatar {
            image.image = UIImage(named: userAvatar) }
        else {
            image.image = UIImage(systemName: "moon") }
        image.layer.cornerRadius = SettingModuleMetrics.avatarImageWidthHeight / 2

        image.tintColor = .systemGray
        return image
    }()

    // MARK: - Elements

    private lazy var nameStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()

    private lazy var buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = SettingModuleMetrics.buttonStackSpacing
        return stack
    }()

    // MARK: - Create Labels

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: SettingModuleMetrics.userLabelFontSize)
        return label
    }()

    private lazy var userSurnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: SettingModuleMetrics.userLabelFontSize)
        return label
    }()

    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: SettingModuleMetrics.userLabelFontSize - 1)
        return label
    }()

    private lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: SettingModuleMetrics.buttonFontSize)
        button.setTitle("изменить пароль", for: .normal)
        button.layer.cornerRadius = SettingModuleMetrics.buttonCornerRadius
        button.layer.backgroundColor = SettingModuleColors.buttonBackground.cgColor
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(showChangePasswordVC), for: .touchUpInside)
        return button
    }()

    private lazy var exitAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: SettingModuleMetrics.buttonFontSize)
        button.setTitle("выйти из аккаунта", for: .normal)
        button.layer.cornerRadius = SettingModuleMetrics.buttonCornerRadius
        button.layer.borderWidth = SettingModuleMetrics.buttonBorderWidth
        button.layer.borderColor = SettingModuleColors.buttonBorder.cgColor
        button.setTitleColor(SettingModuleColors.buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var deleteAccountButton: UIButton = {
        let button = MainCustomButton(cornerRadius: SettingModuleMetrics.buttonCornerRadius)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: SettingModuleMetrics.buttonFontSize)
        button.setTitle("удалить аккаунт", for: .normal)
        button.addTarget(self, action: #selector(deleteAccauntButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func showChangePasswordVC() {
        presenter?.updatePassword()
    }

    @objc private func logOutButtonTapped() {
        presenter?.logout()
    }

    @objc private func deleteAccauntButtonTapped() {
        showDeleteAlert(with: "Удалить аккаунт?",
                             message: "Это действие необратимо",
                             alertAction: { _ in
            self.presenter?.deleteUser()
        })
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        view.backgroundColor = .systemGray6
        presenter?.getUser()
    }

    // MARK: - Setup Hierarchy

    func setupHierarchy() {
        let subviews = [
            userImageView,
            nameStack,
            buttonStack
        ]

        let nameStackSubviews = [
            userNameLabel,
            userSurnameLabel,
            userEmailLabel,
        ]

        let buttonStackSubviews = [
            changePasswordButton,
            exitAccountButton,
            deleteAccountButton
        ]

        nameStackSubviews.forEach { nameStack.addArrangedSubview($0) }
        buttonStackSubviews.forEach { buttonStack.addArrangedSubview($0) }
        subviews.forEach { view.addSubview($0) }
    }

    // MARK: - Setup Layers

    func setupLayers() {

        userImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(
                SettingModuleMetrics.avatarLeadingOffset)
            make.width.height.equalTo(SettingModuleMetrics.avatarImageWidthHeight)
        }

        nameStack.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(
                SettingModuleMetrics.nameStackLeadingTrailingOffset)
            make.trailing.equalTo(view).inset(
                SettingModuleMetrics.nameStackLeadingTrailingOffset)
            make.top.equalTo(userImageView.snp.top)
            make.bottom.equalTo(userImageView.snp.bottom)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(
                SettingModuleMetrics.buttonStackTopOffset)
            make.leading.trailing.equalTo(view).inset(
                SettingModuleMetrics.buttonStackLeadingTrailingOffset)
        }

        changePasswordButton.snp.makeConstraints { make in
            make.height.equalTo(SettingModuleMetrics.buttonHeight)
        }
    }

    // MARK: - Actions

    @objc private func showChangePasswordVC() {
        presenter?.updatePassword()
    }

    @objc private func logOutButtonTapped() {
        presenter?.logout()
    }

    @objc private func deleteAccauntButtonTapped() {
        showDeleteAlert(with: "Удалить аккаунт?",
                        message: "Это действие необратимо",
                        alertAction: { _ in
            self.presenter?.deleteUser()
        })
    }
}

// MARK: - SettingPageViewController Methods

extension SettingPageViewController: SettingPageViewControllerType {

    func setUser(avatar: String?,
                 name: String,
                 surname: String,
                 email: String) {

        if let avatar = avatar {
            userImageView.image = UIImage(named: avatar)
        } else {
            userImageView.image = UIImage(systemName: "moon")
        }

        userNameLabel.text = name
        userSurnameLabel.text = surname
        userEmailLabel.text = email
    }

    func pushUpdatePassordScreen(to vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }

    func logoutSucceeded() {
        guard let window = self.view.window else { return }
        window.switchRootViewController(to: UINavigationController(rootViewController: FirstPageViewController()))
    }

    func logoutFailed(message: String) {
        self.showAlert(withTitle: "Ошибка", message: message)
    }
}
