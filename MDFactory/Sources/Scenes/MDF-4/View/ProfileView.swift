//
//  ProfileVie.swift
//  MDFactory
//
//  Created by Andrei Maskal on 03/09/2022.
//

import UIKit


class ProfileView: UIView {
    
    private lazy var avatarImageView: UIImageView = {
        var imageView = UIImageView()
        let image = UIImage(named: "horse")
        let imageHeightWidth: CGFloat = 170
        imageView.image = image
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeightWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var sheetImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 40
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
        var someView: ProgressView = {
        var imageView = ProgressView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var stripImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.text = "Robert Jakson"
        name.font = UIFont(name: "RedHatDisplay", size: 20.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(sheetImageView)
        addSubview(stripImageView)
        addSubview(someView)
    }
    
    private func setupLayout() {
        
        NSLayoutConstraint.activate([
            avatarImageView.bottomAnchor.constraint(equalTo: topAnchor, constant: 100),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 170),
            avatarImageView.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 15),
            nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            sheetImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            sheetImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            sheetImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            sheetImageView.heightAnchor.constraint(equalToConstant: 240)
            
        ])
        
        NSLayoutConstraint.activate([
            stripImageView.topAnchor.constraint(equalTo: sheetImageView.topAnchor, constant: 14),
            stripImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
    
            stripImageView.heightAnchor.constraint(equalToConstant: 3),
            stripImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            someView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 120),
            someView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -30),
//            someView.leadingAnchor.constraint(equalTo:  safeAreaLayoutGuide.leadingAnchor, constant: 150),
            someView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
//            someView.bottomAnchor.constraint(equalTo: sheetImageView.topAnchor, constant: -60),
            someView.heightAnchor.constraint(equalToConstant: 70),
            someView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
    }
}
