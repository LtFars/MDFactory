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
        let label = WelcomeLabel()
        
        label.getToWelcomeLabelText(firstPartOfText: Strings.firstPartOfWelcomeText,
                                    secondPartOfText: Strings.secondPartOfWelcomeText,
                                    fontSize: Metrics.welcomeTextSize)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subheadlineWelcomeLabel: UILabel = {
        let label = UILabel()
        
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = Metrics.subheadlineWelcomeTextLineHeight
        label.attributedText = NSMutableAttributedString(string: Strings.subheadlineWelcomeText,
                                                         attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                      NSAttributedString.Key.font: UIFont(name: "RedHatDisplay-Medium",
                                                                                                          size: Metrics.subheadlineWelcomeTextSize) ?? UIFont.systemFont(ofSize: Metrics.subheadlineWelcomeTextSize)])
        
        label.textColor = .gray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

// MARK: - Metrics
extension FirstPageViewController {
    enum Metrics {
        static let logoHeightRatio: CGFloat = 542 / 375
        
        static let welcomeTextSize: CGFloat = 28 * UIScreen.main.bounds.height / 928
        static let welcomeTextInsetToTop: CGFloat = 28 * 928 / UIScreen.main.bounds.height + 120
        
        static let subheadlineWelcomeTextSize: CGFloat = 16 * UIScreen.main.bounds.height / 928
        static let subheadlineWelcomeTextLineHeight: CGFloat = 1.17 * UIScreen.main.bounds.height / 928
        static let subheadlineWelcomeTextTopOffset: CGFloat = 12 * UIScreen.main.bounds.height / 928
        static let subheadlineWelcomeTextWidthRatio: CGFloat = 1.3 * 428 / UIScreen.main.bounds.width

    }
    
    enum Strings {
        static let firstPartOfWelcomeText: String = "MobDevFactory"
        static let secondPartOfWelcomeText: String = "App"
        
        static let subheadlineWelcomeText: String = "Добро пожаловать! Освой профессию iOS разработчика на Swift с нуля до Junior за 6 месяцев вместе с нами."
    }
}
