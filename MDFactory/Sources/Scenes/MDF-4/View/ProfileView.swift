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
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = imageHeightWidth / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.text = "Robert Jakson"
        name.font = UIFont(name: "Red Hat Display", size: 20.0)
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
        
    }
}
