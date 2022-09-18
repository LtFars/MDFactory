//
//  ProfileVie.swift
//  MDFactory
//
//  Created by Andrei Maskal on 03/09/2022.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
    // Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStackView()
        setupHierarchy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        let image = UIImage(named: "emoji")
        let imageHeightWidth: CGFloat = 170
        imageView.image = image
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeightWidth / 2
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.text = "Robert Jakson"
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        name.font = .preferredFont(forTextStyle: .headline)
        return name
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    private func addStackView() {
        userInfoStackView.addArrangedSubview(avatarImageView)
        userInfoStackView.addArrangedSubview(nameLabel)
    }
    
    private func setupHierarchy() {
        addSubview(userInfoStackView)
    }
    
    private func setupLayout() {
        
        userInfoStackView.snp.makeConstraints { make in
            make.width.equalTo(Metric.userInfoStackViewWidth)
            make.height.equalTo(Metric.userInfoStackViewHeight)
        }
    }
    
    enum Metric {
        static var userInfoStackViewWidth : CGFloat = 170
        static var userInfoStackViewHeight : CGFloat = 210
    }
}
