//
//  FirstPageView.swift
//  MDFactory
//
//  Created by Виктор on 20/09/2022.
//

import UIKit
import SnapKit

class FirstPageViewController: UIViewController {
    // MARK: - Views
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "firstPageLogo")
        let imageView = UIImageView(image: image)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var welcomeLabel: WelcomeLabel = {
        let label = WelcomeLabel(firstPartOfText: Strings.firstPartOfWelcomeText,
                                 secondPartOfText: Strings.secondPartOfWelcomeText,
                                 fontSize: Metrics.welcomeTextSize)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subheadlineWelcomeLabel: UILabel = {
        let label = UILabel()
        
        var paragraphStyle = NSMutableParagraphStyle()
        var labelFontSize = Metrics.subheadlineWelcomeTextSize
        var attributes = [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                          NSAttributedString.Key.font: UIFont(name: Strings.subheadlineWelcomeFontSize,
                                                              size: labelFontSize) ?? UIFont.systemFont(ofSize: labelFontSize)]
        
        paragraphStyle.lineHeightMultiple = Metrics.subheadlineWelcomeTextLineHeight
        label.attributedText = NSMutableAttributedString(string: Strings.subheadlineWelcomeText,
                                                         attributes: attributes)
        
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var loginButton: MainCustomButton = {
        let button = MainCustomButton(cornerRadius: Metrics.loginButtonsCornerRadius)
        
        button.setTitle(Strings.loginButtonLabelText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Metrics.buttonsFontSize)
        button.addTarget(self, action: #selector(getLoginPage), for: .touchUpInside)

        return button
    }()
    
    private lazy var webVersionReferenceButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle(Strings.webVersionReferenceButtonTitle, for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Metrics.buttonsFontSize)
    
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
        view.addSubview(logoImageView)
        view.addSubview(welcomeLabel)
        view.addSubview(subheadlineWelcomeLabel)
        view.addSubview(loginButton)
        view.addSubview(webVersionReferenceButton)
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(Metrics.logoHeightRatio)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(Metrics.welcomeTextInsetToTop)
            make.centerX.equalToSuperview()
        }
        
        subheadlineWelcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(Metrics.subheadlineWelcomeTextTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(Metrics.subheadlineWelcomeTextWidthRatio)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(subheadlineWelcomeLabel.snp.bottom).offset(Metrics.loginButtonsTopOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(Metrics.loginButtonsWidth)
            make.height.equalTo(Metrics.loginButtonsHeight)
        }
        
        webVersionReferenceButton.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(Metrics.webVersionReferenceButtonTopOffset)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    // MARK: - Methods
    @objc func getLoginPage() {
        navigationController?.pushViewController(LoginPageViewController(), animated: true)
    }
}

// MARK: - Metrics
extension FirstPageViewController {    
    enum Metrics {
        static let logoHeightRatio: CGFloat = 542 / 375
        
        static let welcomeTextSize: CGFloat = 28 * UIScreen.main.bounds.height / 812
        static let welcomeTextInsetToTop: CGFloat = 28 * 812 / UIScreen.main.bounds.height + 120
        
        static let subheadlineWelcomeTextSize: CGFloat = 14 * UIScreen.main.bounds.height / 812
        static let subheadlineWelcomeTextLineHeight: CGFloat = 0.73 * UIScreen.main.bounds.height / 812 + 0.4
        static let subheadlineWelcomeTextTopOffset: CGFloat = 12 * UIScreen.main.bounds.height / 812
        static let subheadlineWelcomeTextWidthRatio: CGFloat = 1.3 * 375 / UIScreen.main.bounds.width
        
        static let loginButtonsCornerRadius: CGFloat = 16 * UIScreen.main.bounds.height / 812
        static let loginButtonsTopOffset: CGFloat = 40 * UIScreen.main.bounds.height / 812
        static let loginButtonsWidth: CGFloat = 315 * UIScreen.main.bounds.width / 375
        static let loginButtonsHeight: CGFloat = 58 * UIScreen.main.bounds.height / 812
        
        static let webVersionReferenceButtonTopOffset: CGFloat = 35 * UIScreen.main.bounds.height / 812
        static let buttonsFontSize: CGFloat = 14 * UIScreen.main.bounds.height / 812
    }
    
    enum Strings {
        static let firstPartOfWelcomeText: String = "MobDevFactory"
        static let secondPartOfWelcomeText: String = "App"
        
        static let subheadlineWelcomeFontSize: String = "RedHatDisplay-Medium"
        static let subheadlineWelcomeText: String = "Добро пожаловать! Освой профессию iOS разработчика на Swift с нуля до Junior за 6 месяцев вместе с нами."
        
        static let loginButtonLabelText: String = "Войти"
        
        static let webVersionReferenceButtonTitle: String = "Веб-версия MobDevFactory"
    }
}
