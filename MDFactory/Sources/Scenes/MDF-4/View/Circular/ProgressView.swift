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
        setupLoyaut()
        
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
    
    private func setupLoyaut() {
        
        someView.snp.makeConstraints { make in
            make.width.height.equalTo(130)
            make.centerX.equalTo(snp.centerX)
           
            
            
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
    }
}
