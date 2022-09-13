//
//  ProfileVie.swift
//  MDFactory
//
//  Created by Andrei Maskal on 03/09/2022.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    
   var sheetView = GestureRecognizerSheetView()
    
    // Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        sheetView.recognizerView()
        setupHierarchy()
        addStackView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Properties
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
    
//    var sheetImageView: UIImageView = {
//        var imageView = UIImageView()
//        imageView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
//        imageView.layer.cornerRadius = 40
//        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        imageView.clipsToBounds = true
//        return imageView
//    }()
//
//    private lazy var stripImageView: UIImageView = {
//        var imageView = UIImageView()
//        imageView.layer.cornerRadius = 2
//        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
//
//        return imageView
//    }()
    
    private lazy var centerImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        var name = UILabel()
        name.text = "Robert Jakson"
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        name.font = .preferredFont(forTextStyle: .headline)
        return name
    }()
    
    private lazy var centerLabel: UILabel = {
        var name = UILabel()
        name.text = "FR"
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        return name
    }()
    
    private lazy var userInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var centerLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    private lazy var percentSpeaking = setupPercentLabel(percent: "14%")
    private lazy var percentListening = setupPercentLabel(percent: "46%")
    private lazy var percentReading = setupPercentLabel(percent: "65%")
    
    private lazy var nameSpeaking = setupNamePercentLabel(percent: "Speaking",
                                                          color: Color.red.color)
    private lazy var nameListening = setupNamePercentLabel(percent: "Listening",
                                                           color: Color.blue.color)
    private lazy var nameReading = setupNamePercentLabel(percent: "Reading",
                                                         color: Color.green.color)
    // Custom properties
        var someView: ProgressView = {
        var imageView = ProgressView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // Metods
    private func setupPercentLabel(percent: String) -> UILabel {
        let name = UILabel()
        name.text = percent
        name.textColor = .white
        name.font = .systemFont(ofSize: 9, weight: .heavy)
        return name
    }
    
    private func setupNamePercentLabel(percent: String, color: UIColor) -> UILabel {
        let name = UILabel()
        name.text = percent
        name.textColor = color
        name.font = .systemFont(ofSize: 12, weight: .regular)
        return name
    }
    
    private func addStackView() {
        userInfoStackView.addArrangedSubview(avatarImageView)
        userInfoStackView.addArrangedSubview(nameLabel)
        centerLabelStackView.addArrangedSubview(centerLabel)
        centerLabelStackView.addArrangedSubview(centerImageView)
    }
    
    private func setupHierarchy() {
        addSubview(userInfoStackView)
        addSubview(centerLabelStackView)
        addSubview(sheetView.sheetImageView)
        addSubview(sheetView.stripImageView)
        addSubview(someView)
        addSubview(percentSpeaking)
        addSubview(percentListening)
        addSubview(percentReading)
        addSubview(nameSpeaking)
        addSubview(nameListening)
        addSubview(nameReading)
    }
    
    private func setupLayout() {
        
        userInfoStackView.snp.makeConstraints { make in
            make.width.equalTo(Metric.userInfoStackViewWidth)
            make.height.equalTo(Metric.userInfoStackViewHeight)
            make.top.equalTo(-Metric.userInfoStackViewTopAncor)
            make.centerX.equalToSuperview()
        }
        
        sheetView.sheetImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
        }

        sheetView.stripImageView.snp.makeConstraints { make in
            make.top.equalTo(sheetView.sheetImageView.snp.top).offset(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(3)
            make.width.equalTo(50)
        }
        
        someView.snp.makeConstraints { make in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(sheetView.sheetImageView.snp.top).offset(-50)
            make.height.width.equalTo(130)
        }

        percentSpeaking.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX).offset(65)
            make.centerY.equalTo(someView.snp.centerY).offset(0)
        }
        
        percentListening.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX).offset(33)
            make.centerY.equalTo(someView.snp.centerY).offset(55)
        }

        percentReading.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX).offset(-55)
            make.centerY.equalTo(someView.snp.centerY).offset(33)
        }
        
        nameSpeaking.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.top).offset(-5)
            make.trailing.equalTo(someView.snp.leading).offset(25)
        }
        
        nameListening.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.centerY).offset(30)
            make.leading.equalTo(someView.snp.trailing).offset(35)
        }
        
        nameReading.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.centerY).offset(15)
            make.trailing.equalTo(someView.snp.leading).offset(-25)
        }
        
        centerLabelStackView.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX)
            make.centerY.equalTo(someView.snp.centerY)
        }
    }
    
    enum Metric {
        static var userInfoStackViewWidth : CGFloat = 170
        static var userInfoStackViewHeight : CGFloat = 210
        static var userInfoStackViewTopAncor : CGFloat = 60

    }
}
