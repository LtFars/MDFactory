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
    }
    
    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(view.snp.width).multipliedBy(Metrics.logoHeightRatio)
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
    }
}
