//
//  SheetProfileView.swift
//  MDFactory
//
//  Created by Andrei Maskal on 18/09/2022.
//

import UIKit

class SheetProfileView: UIView {
    
    private let profileView = ProfileView()
    private let progressView = ProgressView()
    
    private lazy var sheetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 40
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLoyaut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupHierarchy() {
        addSubview(sheetImageView)
        sheetImageView.addSubview(progressView)
        sheetImageView.addSubview(profileView)
    }
    
    private func setupLoyaut() {
        
        sheetImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(0)
            make.top.lessThanOrEqualTo(650)
        }
        
        profileView.snp.makeConstraints { make in
            make.width.equalTo(Metric.userInfoStackViewWidth)
            make.height.equalTo(Metric.userInfoStackViewHeight)
            make.top.equalTo(sheetImageView.snp.top).offset(-Metric.userInfoStackViewTopAncor)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalTo(profileView.snp.centerX)
            make.top.equalTo(profileView.snp.bottom).offset(70)
            
        }
        
    }
    
    enum Metric {
        static var userInfoStackViewWidth : CGFloat = 170
        static var userInfoStackViewHeight : CGFloat = 210
        static var userInfoStackViewTopAncor : CGFloat = 60
        
    }
    
    
}
