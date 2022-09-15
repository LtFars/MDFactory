//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

class ProfileViewController: BottomSheetController {
    
    var profileView = ProfileView()
    var progressView = ProgressView()
    
    let defaultHeight: CGFloat = 170
    let dismissibleHeight: CGFloat = 100
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 150
 
    var currentContainerHeight: CGFloat = 100

    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
  
    var sheetImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var stripImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
        
        return imageView
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
    }
    
    func setupLoyaut() {
        
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
            
        }
        
        stripImageView.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.top).offset(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(3)
            make.width.equalTo(50)
            
            containerViewHeightConstraint = sheetImageView.heightAnchor.constraint(equalToConstant: defaultHeight)
                        
            containerViewHeightConstraint?.isActive = true
            containerViewBottomConstraint?.isActive = true
            
        }
    }
        
        func setupPanGesture() {
   
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
            panGesture.minimumNumberOfTouches = 1
            panGesture.delaysTouchesBegan = false
            panGesture.delaysTouchesEnded = false
            view.addGestureRecognizer(panGesture)
        }
        
        func animateContainerHeight(_ height: CGFloat) {
            UIView.animate(withDuration: 0.4) {
                self.containerViewHeightConstraint?.constant = height
                self.view.layoutIfNeeded()
            }
            // Save current height
            currentContainerHeight = height
        }
        
        @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: view)
          
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
