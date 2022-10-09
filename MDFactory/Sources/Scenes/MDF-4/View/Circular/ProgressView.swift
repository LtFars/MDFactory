//
//  ProgressView.swift
//  MDFactory
//
//  Created by Andrei Maskal on 15/09/2022.
//

import UIKit
import SnapKit

class ProgressView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addStackView()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var centerLabel: UILabel = {
        var name = UILabel()
        name.text = "FR"
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        return name
    }()
    
    private lazy var someView: CircularView = {
        var imageView = CircularView()
        return imageView
    }()
    
    private lazy var centerImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.down")
        imageView.tintColor = .black
        return imageView
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
        name.font = .systemFont(ofSize: 12, weight: .heavy)
        return name
    }
    
    private func addStackView() {
        centerLabelStackView.addArrangedSubview(centerLabel)
        centerLabelStackView.addArrangedSubview(centerImageView)
    }
    
    private func setupHierarchy() {
        addSubview(centerLabelStackView)
        addSubview(someView)
        addSubview(percentSpeaking)
        addSubview(percentListening)
        addSubview(percentReading)
        addSubview(nameSpeaking)
        addSubview(nameListening)
        addSubview(nameReading)
    }
    
    private func setupLayout() {
        
        someView.snp.makeConstraints { make in
            make.width.height.equalTo(MetricConstraints.someViewWidthHeight)
            make.centerX.equalTo(snp.centerX)
        }
        percentSpeaking.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX).offset(MetricConstraints.percentSpeakingX)
            make.centerY.equalTo(someView.snp.centerY).offset(MetricConstraints.percentSpeakingY)
        }
        
        percentListening.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX).offset(MetricConstraints.percentListeningX)
            make.centerY.equalTo(someView.snp.centerY).offset(MetricConstraints.percentListeningY)
        }
        
        percentReading.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX).offset(-MetricConstraints.percentReadingX)
            make.centerY.equalTo(someView.snp.centerY).offset(MetricConstraints.percentReadingY)
        }
        
        nameSpeaking.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.top).offset(-MetricConstraints.nameSpeakingTop)
            make.trailing.equalTo(someView.snp.leading).offset(MetricConstraints.nameSpeakingTrailing)
        }
        
        nameListening.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.centerY).offset(MetricConstraints.nameListeningTop)
            make.leading.equalTo(someView.snp.trailing).offset(MetricConstraints.nameListeningLeading)
        }
        
        nameReading.snp.makeConstraints { make in
            make.top.equalTo(someView.snp.centerY).offset(MetricConstraints.nameReadingTop)
            make.trailing.equalTo(someView.snp.leading).offset(-MetricConstraints.nameReadingTrailing)
        }
        
        centerLabelStackView.snp.makeConstraints { make in
            make.centerX.equalTo(someView.snp.centerX)
            make.centerY.equalTo(someView.snp.centerY)
        }
        
    }
    
    enum MetricConstraints {
        static var someViewWidthHeight: CGFloat = 130
        static var percentSpeakingX: CGFloat = 65
        static var percentSpeakingY: CGFloat = 0
        static var percentListeningX: CGFloat = 33
        static var percentListeningY: CGFloat = 55
        static var percentReadingX: CGFloat = 55
        static var percentReadingY: CGFloat = 33
        static var nameSpeakingTop: CGFloat = 5
        static var nameSpeakingTrailing: CGFloat = 25
        static var nameListeningTop: CGFloat = 30
        static var nameListeningLeading: CGFloat = 35
        static var nameReadingTop: CGFloat = 15
        static var nameReadingTrailing: CGFloat = 25

    }
}

