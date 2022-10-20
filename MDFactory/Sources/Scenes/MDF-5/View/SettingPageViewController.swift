//
//  SettingPageViewController.swift
//  MDFactory
//
//  Created by Dmitry Dorodniy on 16.10.2022.
//

import UIKit
import SnapKit

class SettingPageViewController: UIViewController {

    private lazy var userImage: UIImageView = {
        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 75
        image.image = UIImage(named: "emoji")
        image.tintColor = .systemGray
        return image
    }()

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
        return stack
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()

    private lazy var familyLabel: UILabel = {
        let label = UILabel()
        label.text = "Family"
        return label
    }()

    private lazy var mailLabel: UILabel = {
        let label = UILabel()
        label.text = "mail@mail.com"
        return label
    }()

    private lazy var changePasswordButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.strokeColor = .systemFill
        config.title = "изменить пароль"
        button.configuration = config
        return button
    }()

    private lazy var exitAccountButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.strokeColor = .systemFill
        config.title = "выйти из аккаунта"
        button.configuration = config
        return button
    }()

    private lazy var deleteAccountButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.background.strokeColor = .systemFill
        config.title = "удалить аккаунт"
        button.configuration = config
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierarchy()
        setupLayer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       view.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)

    }

    func setupHierarchy() {
        view.addSubview(userImage)
        view.addSubview(nameStack)
        view.addSubview(buttonStack)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(familyLabel)
        nameStack.addArrangedSubview(mailLabel)
        buttonStack.addArrangedSubview(changePasswordButton)
        buttonStack.addArrangedSubview(exitAccountButton)
        buttonStack.addArrangedSubview(deleteAccountButton)
    }

// MARK: - Setup Layer

    func setupLayer() {



        userImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }

        nameStack.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(20)
            make.top.equalTo(userImage.snp.top)
            make.bottom.equalTo(userImage.snp.bottom)
        }

        buttonStack.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(100)
            make.leading.trailing.equalTo(view).inset(20)
        }


    }
}
