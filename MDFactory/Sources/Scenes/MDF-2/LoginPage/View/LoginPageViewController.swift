//
//  LoginPageViewController.swift
//  MDFactory
//
//  Created by Виктор on 24/09/2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    // MARK: - Properties
    private lazy var loginTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "E-mail")
        
        textField.translatesAutoresizingMaskIntoConstraints = false
    
        return textField
    }()
    
    private lazy var passwordTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Пароль", secureTextMode: true)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
    
        return textField
    }()
    
    private lazy var loginButton: MainCustomButton = {
        let button = MainCustomButton(cornerRadius: Metrics.uiCorners)
        
        button.setTitle(Strings.loginButtonLabelText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupLayout()
        setupView()
    }
    
    // MARK: - Settings
    private func setupHierarchy() {
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        view.addSubview(loginTextField)
    }
    
    private func setupLayout() {
        loginTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(183)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.uiWidth)
            make.height.equalTo(Metrics.uiHeight)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.uiWidth)
            make.height.equalTo(Metrics.uiHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.uiWidth)
            make.height.equalTo(Metrics.uiHeight)
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        title = Strings.titleText
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

// MARK: - Metrics
extension LoginPageViewController {
    enum Metrics {
        static let uiCorners: CGFloat = 16 * UIScreen.main.bounds.height / 812
        static let uiWidth: CGFloat = 315 * UIScreen.main.bounds.width / 375
        static let uiHeight: CGFloat = 58 * UIScreen.main.bounds.height / 812
    }
    
    enum Strings {
        static let loginButtonLabelText: String = "Войти"
        static let titleText: String = "Авторизация"
    }
}
