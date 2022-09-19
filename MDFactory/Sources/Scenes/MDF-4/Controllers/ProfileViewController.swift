//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let sheetProfileView = SheetProfileView()
    
    
    private let defaultHeight: CGFloat = 800
    private let dismissibleHeight: CGFloat = 100
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 140
    private var currentContainerHeight: CGFloat = 100
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
  
    private lazy var sheetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
        imageView.layer.cornerRadius = 40
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .close)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tabActiohButton), for: .touchUpInside)
        return button
    }()
    
    
   private lazy var stripImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 2
        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
        return imageView
    }()
//
//    private lazy var centerLabel: UILabel = {
//        var name = UILabel()
//        name.text = "FRTRTRTRTRT"
//        name.font = .systemFont(ofSize: 21, weight: .heavy)
//        return name
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupHierarchy()
        setupLoyaut()
        setupPanGesture()
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    private func setupHierarchy() {
        view.addSubview(sheetProfileView)
        view.addSubview(sheetImageView)
        view.addSubview(stripImageView)
        view.addSubview(backButton)
//        sheetImageView.addSubview(centerLabel)
    }
    
    private func setupLoyaut() {
        
        sheetProfileView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(0)
            make.top.equalTo(view.snp.top).offset(-500)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.leading.equalTo(20)
            
        }
        
        sheetImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(0)
            make.bottom.equalTo(600)
//            make.top.equalTo(view.snp.top).offset(-200)
        }
        
        stripImageView.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.top).offset(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(3)
            make.width.equalTo(50)
            
//            centerLabel.snp.makeConstraints { make in
//                make.centerX.equalToSuperview()
//                make.centerY.equalToSuperview()
//            }
            
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
           
            let isDraggingDown = translation.y > 0
           
//            if isDraggingDown {
//                sheetImageView.snp.makeConstraints { make in
////                    make.bottom.equalTo(translation.y)
//                }
//            }
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
        
    
   @objc func tabActiohButton() {
        dismiss(animated: true)
    }
//    enum Metric {
//        static var userInfoStackViewWidth : CGFloat = 170
//        static var userInfoStackViewHeight : CGFloat = 210
//        static var userInfoStackViewTopAncor : CGFloat = 60
//        
//    }
    
}
