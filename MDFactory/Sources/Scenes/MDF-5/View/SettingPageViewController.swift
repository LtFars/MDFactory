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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.image = UIImage(systemName: "person.circle")
        image.tintColor = .systemGray
        return image
    }()

    private lazy var nameStack: UIStackView = {
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


    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true

        setupLayer()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        view.backgroundColor = .blue
    }

    func setupLayer() {

        view.addSubview(userImage)
        view.addSubview(nameStack)
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(familyLabel)
        nameStack.addArrangedSubview(mailLabel)

        userImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }

        nameStack.snp.makeConstraints { make in
            make.leading.equalTo(userImage.snp.trailing).offset(20)
            make.top.equalTo(userImage.snp.top)
            make.bottom.equalTo(userImage.snp.bottom)

        }
    }
}
