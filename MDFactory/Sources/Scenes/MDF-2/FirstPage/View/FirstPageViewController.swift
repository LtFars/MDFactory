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
        label.adjustsFontSizeToFitWidth = true
        
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
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
}

// MARK: - Metrics
extension FirstPageViewController {
    enum Metrics {
        static let logoHeightRatio: CGFloat = 542 / 375
        
        static let welcomeTextSize: CGFloat = 28
        static let welcomeTextInsetToTop: CGFloat = 140
        
    }
    
    enum Strings {
        static let firstPartOfWelcomeText: String = "MobDevFactory"
        static let secondPartOfWelcomeText: String = "App"
        
    }
}
