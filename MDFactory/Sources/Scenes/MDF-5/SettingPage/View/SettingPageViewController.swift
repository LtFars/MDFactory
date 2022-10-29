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
    func setUser(avatar: String,
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
        image.tintColor = .systemGray
        return image
    }()

    // MARK: - Create stacks

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
        stack.spacing = 20
        return stack
    }()

    // MARK: - Create Labels

    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private lazy var userSurnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()

    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    // MARK: - Create buttons

    private lazy var changePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("изменить пароль", for: .normal)
        button.layer.cornerRadius = 16 * UIScreen.main.bounds.height / 812
        button.layer.backgroundColor = UIColor.systemGray5.cgColor
        button.setTitleColor(UIColor.gray, for: .normal)
        button.addTarget(self, action: #selector(showChangePasswordVC), for: .touchUpInside)
        return button
    }()

    private lazy var exitAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitle("выйти из аккаунта", for: .normal)
        button.layer.cornerRadius = 16 * UIScreen.main.bounds.height / 812
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hue: 252/360, saturation: 0.79, brightness: 1, alpha: 1).cgColor
        button.setTitleColor(UIColor(hue: 252/360, saturation: 0.79, brightness: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var deleteAccountButton: UIButton = {
        let button = MainCustomButton(cornerRadius: 16 * UIScreen.main.bounds.height / 812)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }

        nameStack.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
            make.trailing.equalTo(view).inset(20)
            make.top.equalTo(userImageView.snp.top)
            make.bottom.equalTo(userImageView.snp.bottom)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(100)
            make.leading.trailing.equalTo(view).inset(30)
        }

        changePasswordButton.snp.makeConstraints { make in
            make.height.equalTo(58 * UIScreen.main.bounds.height / 812)
        }
    }
}

// MARK: - SettingPageViewController Methods

extension SettingPageViewController: SettingPageViewControllerType {

    func setUser(avatar: String,
                 name: String,
                 surname: String,
                 email: String) {

        userImageView.image = UIImage(named: avatar)
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
