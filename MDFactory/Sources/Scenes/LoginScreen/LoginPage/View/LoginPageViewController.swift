//
//  LoginPageViewController.swift
//  MDFactory
//
//  Created by Виктор on 24/09/2022.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "back")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: Metrics.titleLabelFontSize)
        label.text = Strings.titleText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "E-mail")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.autocapitalizationType = .none
        textField.returnKeyType = UIReturnKeyType.next
        textField.tag = 0
        return textField
    }()
    
    private lazy var passwordTextField: CustomLoginTextField = {
        let textField = CustomLoginTextField(labelText: "Пароль", secureTextMode: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = UIReturnKeyType.go
        textField.tag = 1
        return textField
    }()
    
    private lazy var loginButton: MainCustomButton = {
        let button = MainCustomButton(cornerRadius: Metrics.uiCorners)
        button.setTitle(Strings.loginButtonLabelText, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: Metrics.loginButtonFontSize)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgetPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.forgetPasswordLabelText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Metrics.forgetPasswordFontSize)
        button.setTitleColor(UIColor.gray, for: .normal)
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
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        view.addSubview(loginTextField)
        view.addSubview(forgetPasswordButton)
    }
    
    private func setupLayout() {
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Metrics.backButtonTopOffset)
            make.leading.equalTo(loginTextField.snp.leading)
            make.width.equalTo(Metrics.backButtonSideDimension)
            make.height.equalTo(Metrics.backButtonSideDimension)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(Metrics.titleLabelTopOffset)
            make.leading.equalTo(loginTextField.snp.leading)
        }
        
        loginTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(Metrics.loginTextFieldTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.uiWidth)
            make.height.equalTo(Metrics.uiHeight)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(loginTextField.snp.bottom).offset(Metrics.passwordTextFieldTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.uiWidth)
            make.height.equalTo(Metrics.uiHeight)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Metrics.loginButtonFieldTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.uiWidth)
            make.height.equalTo(Metrics.uiHeight)
        }
        
        forgetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(Metrics.forgetPasswordButtonFieldTopOffset)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Actions
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginAction() {
        // To access tabBar use
        // userName: test@test.com
        // password: password
        
        guard let email = loginTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            showAlert(withTitle: "Ошибка", message: "Заполнены не все поля.")
            return
        }
        
        FirebaseService().signIn(email: email, password: password) { [weak self] result in
            switch result {
            case .success:
                self?.savePasswordToSecure(email: email, password: password)
                guard let window = self?.view.window else { return }
                window.switchRootViewController(to: MainTabBarController())
            case .failure(let error):
                self?.showAlert(withTitle: "Ошибка", message: "\(error.localizedDescription)")
            }
        }
    }
    
    private func savePasswordToSecure(email: String, password: String) {
        do {
            if try SecureStorage.isExists(userName: email) {
                try SecureStorage.updatePassword(userName: email, to: password)
                print("LOGIN: password for \(email) has been updated")
            } else {
                try SecureStorage.save(userName: email, password: password)
                print("LOGIN: new password \(password) for \(email) has been saved")
            }
        } catch {
            print("\(error)")
        }
    }
}

// MARK: - Metrics

extension LoginPageViewController {
    enum Metrics {
        static let backButtonTopOffset: CGFloat = 50 * UIScreen.main.bounds.height / 812
        static let backButtonSideDimension: CGFloat = 44 * UIScreen.main.bounds.height / 812
        
        static let titleLabelTopOffset: CGFloat = 34 * UIScreen.main.bounds.height / 812
        static let titleLabelFontSize: CGFloat = 28 * UIScreen.main.bounds.height / 812
        
        static let loginTextFieldTopOffset: CGFloat = 40 * UIScreen.main.bounds.height / 812
        
        static let passwordTextFieldTopOffset: CGFloat = 15 * UIScreen.main.bounds.height / 812
        
        static let loginButtonFieldTopOffset: CGFloat = 25 * UIScreen.main.bounds.height / 812
        static let loginButtonFontSize: CGFloat = 14 * UIScreen.main.bounds.height / 812
        
        static let uiCorners: CGFloat = 16 * UIScreen.main.bounds.height / 812
        static let uiWidth: CGFloat = 315 * UIScreen.main.bounds.width / 375
        static let uiHeight: CGFloat = 58 * UIScreen.main.bounds.height / 812
        
        static let forgetPasswordButtonFieldTopOffset: CGFloat = 36 * UIScreen.main.bounds.height / 812
        static let forgetPasswordFontSize = 14 * UIScreen.main.bounds.height / 812
    }
    
    enum Strings {
        static let loginButtonLabelText: String = "Войти"
        
        static let titleText: String = "Вход"
        
        static let forgetPasswordLabelText: String = "Забыли пароль?"
    }
}

// MARK: - UITextFieldDelegate

extension LoginPageViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            self.loginAction()
            return true
        }
        return false
    }
}
