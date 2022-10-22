//
//  SettingPageViewController.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 16.10.2022.
//

import UIKit
import SnapKit

protocol SettingPageViewControllerType: AnyObject {
    func logoutSucceeded()
    func logoutFailed(message: String)
}

class SettingPageViewController: UIViewController {

    var presenter: SettingPagePresenterType?

    private lazy var userImage: UIImageView = {
        let image = UIImageView()
       image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 75
        image.image = UIImage(named: "emoji")
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

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Константин"
        return label
    }()

    private lazy var familyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Константинопольский"
        return label
    }()

    private lazy var mailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "mail.konstantin@mail.ru"
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
        //        button.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func showChangePasswordVC() {
        let vc = ChangePasswordSettingPageViewController()
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true)
    }

    @objc private func logOutButtonTapped() {
        presenter?.logout()
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//       view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
        view.backgroundColor = .systemGray6

    }

    // MARK: - Setup Hierarchy

    func setupHierarchy() {
        let subviews = [userImage, nameStack, buttonStack]

        let nameStackSubviews = [
            nameLabel,
            familyLabel,
            mailLabel,
        ]

        let buttonStackSubviews = [
            changePasswordButton,
            exitAccountButton,
            deleteAccountButton
        ]

        nameStackSubviews.forEach { nameStack.addArrangedSubview($0) }
        buttonStackSubviews.forEach { buttonStack.addArrangedSubview($0) }
        subviews.forEach { view.addSubview($0) }
//        view.addSubview(userImage)
//        view.addSubview(nameStack)
//        view.addSubview(buttonStack)
//        nameStack.addArrangedSubview(nameLabel)
//        nameStack.addArrangedSubview(familyLabel)
//        nameStack.addArrangedSubview(mailLabel)
//        buttonStack.addArrangedSubview(changePasswordButton)
//        buttonStack.addArrangedSubview(exitAccountButton)
//        buttonStack.addArrangedSubview(deleteAccountButton)
    }

// MARK: - Setup Layers

    func setupLayers() {

        userImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }

        nameStack.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(20)
            make.trailing.equalTo(view).inset(20)
            make.top.equalTo(userImage.snp.top)
            make.bottom.equalTo(userImage.snp.bottom)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(100)
            make.leading.trailing.equalTo(view).inset(20)
        }

        changePasswordButton.snp.makeConstraints { make in
//            make.width.equalTo(315 * UIScreen.main.bounds.width / 375)
            make.height.equalTo(58 * UIScreen.main.bounds.height / 812)
        }
    }
}

extension SettingPageViewController: SettingPageViewControllerType {

    func logoutSucceeded() {
        guard let window = self.view.window else { return }
        window.switchRootViewController(to: UINavigationController(rootViewController: FirstPageViewController()))
    }

    func logoutFailed(message: String) {
        self.showAlert(withTitle: "Ошибка", message: message)
    }
}
