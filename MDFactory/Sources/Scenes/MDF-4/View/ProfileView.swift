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
        let image = UIImage(named: "emoji")
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
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        name.font = .preferredFont(forTextStyle: .headline)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var centerLabel: UILabel = {
        var name = UILabel()
        name.text = "FR"
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var centerImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private func setupPercentLabel(percent: String) -> UILabel {
        let name = UILabel()
        name.text = percent
        name.textColor = .white
        name.font = .systemFont(ofSize: 9, weight: .heavy)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }
    
    private func setupNamePercentLabel(percent: String, color: UIColor) -> UILabel {
        let name = UILabel()
        name.text = percent
        name.textColor = color
        name.font = .systemFont(ofSize: 12, weight: .regular)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }
    
    private lazy var percentSpeaking = setupPercentLabel(percent: "14%")
    private lazy var percentListening = setupPercentLabel(percent: "46%")
    private lazy var percentReading = setupPercentLabel(percent: "65%")
    
    private lazy var nameSpeaking = setupNamePercentLabel(percent: "Speaking",
                                                          color: Color.red.color)
    private lazy var nameListening = setupNamePercentLabel(percent: "Listening",
                                                           color: Color.blue.color)
    private lazy var nameReading = setupNamePercentLabel(percent: "Reading",
                                                         color: Color.green.color)
    
    
    
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
        addSubview(percentSpeaking)
        addSubview(percentListening)
        addSubview(percentReading)
        addSubview(nameSpeaking)
        addSubview(nameListening)
        addSubview(nameReading)
        addSubview(centerLabel)
        addSubview(centerImageView)
        
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
            someView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 100),
            someView.centerXAnchor.constraint(equalTo: centerXAnchor),
            someView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            someView.heightAnchor.constraint(equalToConstant: 130),
            someView.widthAnchor.constraint(equalToConstant: 130)
        ])
        
        NSLayoutConstraint.activate([
            percentSpeaking.centerXAnchor.constraint(equalTo: someView.centerXAnchor, constant: 65),
            percentSpeaking.centerYAnchor.constraint(equalTo: someView.centerYAnchor, constant: 0),
            
            percentListening.centerXAnchor.constraint(equalTo: percentSpeaking.centerXAnchor, constant: -30),
            percentListening.centerYAnchor.constraint(equalTo: percentSpeaking.centerYAnchor, constant: 55),
            
            percentReading.centerXAnchor.constraint(equalTo: someView.centerXAnchor, constant: -55),
            percentReading.centerYAnchor.constraint(equalTo: someView.centerYAnchor, constant: 33)
            
        ])
        
        
        NSLayoutConstraint.activate([
            nameSpeaking.topAnchor.constraint(equalTo: someView.topAnchor, constant: -5),
            nameSpeaking.trailingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 25),
            
            nameListening.topAnchor.constraint(equalTo: someView.centerYAnchor, constant: 30),
            nameListening.leadingAnchor.constraint(equalTo: someView.trailingAnchor, constant: 35),
            
            nameReading.trailingAnchor.constraint(equalTo: someView.leadingAnchor, constant: -25),
            nameReading.topAnchor.constraint(equalTo: someView.centerYAnchor, constant: 15)
            
        ])
        
        NSLayoutConstraint.activate([
            centerLabel.centerXAnchor.constraint(equalTo: someView.centerXAnchor, constant: -10),
            centerLabel.centerYAnchor.constraint(equalTo: someView.centerYAnchor, constant: 0),
            
            centerImageView.leadingAnchor.constraint(equalTo: centerLabel.trailingAnchor, constant: 5),
            centerImageView.centerYAnchor.constraint(equalTo: someView.centerYAnchor, constant: 0)
            
        ])
        
    }
}
