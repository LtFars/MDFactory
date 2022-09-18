//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

class ProfileViewController: BottomSheetController {
    
    private let profileView = ProfileView()
    private let progressView = ProgressView()
    
    private let defaultHeight: CGFloat = 200
    private let dismissibleHeight: CGFloat = 100
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 150
 
    private var currentContainerHeight: CGFloat = 100

    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
  
    private lazy var sheetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
   private lazy var stripImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
        return imageView
    }()
    
    private lazy var centerLabel: UILabel = {
        var name = UILabel()
        name.text = "FRTRTRTRTRT"
        name.font = .systemFont(ofSize: 21, weight: .heavy)
        return name
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLoyaut()
        setupPanGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func setupHierarchy() {
        view.addSubview(progressView)
        view.addSubview(profileView)
        view.addSubview(sheetImageView)
        view.addSubview(stripImageView)
        sheetImageView.addSubview(centerLabel)
    }
    
    private func setupLoyaut() {
        
        profileView.snp.makeConstraints { make in
            make.width.equalTo(Metric.userInfoStackViewWidth)
            make.height.equalTo(Metric.userInfoStackViewHeight)
            make.top.equalTo(-Metric.userInfoStackViewTopAncor)
            make.centerX.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.centerX.equalTo(profileView.snp.centerX)
            make.top.equalTo(profileView.snp.bottom).offset(70)
            
        }
        
        sheetImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(0)
//            make.height.equalTo(800)
//            make.bottom.equalTo(view.snp.bottom).offset(600)
        }
        
        stripImageView.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.top).offset(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(3)
            make.width.equalTo(50)
            
            centerLabel.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
            
            containerViewHeightConstraint = sheetImageView.heightAnchor.constraint(equalToConstant: defaultHeight)
                        
            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
            
        }
    }
        
    private func setupPanGesture() {
   
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
            panGesture.minimumNumberOfTouches = 1
            panGesture.delaysTouchesBegan = false
            panGesture.delaysTouchesEnded = false
            view.addGestureRecognizer(panGesture)
        }
        
    private func animateContainerHeight(_ height: CGFloat) {
            UIView.animate(withDuration: 0.4) {
                self.containerViewHeightConstraint?.constant = height
                self.view.layoutIfNeeded()
            }
          
            currentContainerHeight = height
        }
        
        @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: view)
            
//            sheetImageView.snp.makeConstraints { make in
//                make.leading.trailing.equalTo(0)
//    //            make.height.equalTo(800)
//                make.bottom.equalTo(view.snp.bottom).offset(0)
//            }
          
            let isDraggingDown = translation.y > 0
           
            let newHeight = currentContainerHeight - translation.y
            
            switch gesture.state {
            case .changed:
         
                if newHeight < maximumContainerHeight {
            
                    containerViewHeightConstraint?.constant = newHeight
                    view.layoutIfNeeded()
                }
            case .ended:
             
                if newHeight < defaultHeight {
                    
                    animateContainerHeight(defaultHeight)
                }
                else if newHeight < maximumContainerHeight && isDraggingDown {
                
                    animateContainerHeight(defaultHeight)
                }
                else if newHeight > defaultHeight && !isDraggingDown {
                  
                    animateContainerHeight(maximumContainerHeight)
                }
            default:
                break
            }
            
        }
        
    enum Metric {
        static var userInfoStackViewWidth : CGFloat = 170
        static var userInfoStackViewHeight : CGFloat = 210
        static var userInfoStackViewTopAncor : CGFloat = 60
        
    }
    
}
