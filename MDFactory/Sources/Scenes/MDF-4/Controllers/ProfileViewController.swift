//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    private let sheetProfileView = SheetProfileView()
    
    private let defaultHeight: CGFloat = UIScreen.main.bounds.height / 3.5
    private let dismissibleHeight: CGFloat = 100
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    private var currentContainerHeight: CGFloat = 100
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    private lazy var achievementsButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = Color.gray.color
        button.setTitle("Achievements", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = MetricConstraints.achievementsButtonCornerRadius
        button.addTarget(self, action: #selector(showAchievements), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupHierarchy()
        setupLoyaut()
    }
  
    private func setupHierarchy() {
        view.addSubview(sheetProfileView)
        view.addSubview(achievementsButton)
    }
    
    @objc func showAchievements() {
        let bounds = achievementsButton.bounds
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 11,
                       options: .curveEaseInOut) {
            self.achievementsButton.bounds = CGRect(x: bounds.origin.x - 30,
                                                    y: bounds.origin.y,
                                                    width: bounds.width + 60,
                                                    height: bounds.height)
            self.achievementsButton.titleLabel?.bounds = CGRect(x: bounds.origin.x - 30,
                                                                y: bounds.origin.y,
                                                                width: bounds.width + 60,
                                                                height: bounds.height)
        }
        
        let achievementsController = AchievementsViewController()
        if let sheet = achievementsController.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
        }
        navigationController?.present(achievementsController, animated: true)
    }
  
    private func setupLoyaut() {
        
        sheetProfileView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(MetricConstraints.sheetConstraintsLeadingBottomTrailing)
        }
        
        achievementsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.centerY).offset(MetricConstraints.achievementsButtonTop)
            make.height.equalTo(MetricConstraints.achievementsButtonHeight)
            make.width.equalTo(MetricConstraints.achievementsButtonWidth)
        }
    }
    
    enum MetricConstraints {
        static var sheetConstraintsLeadingBottomTrailing: CGFloat = 0
        static var achievementsCollectionTop: CGFloat = 50
        static var achievementsButtonTop: CGFloat = 150
        static var achievementsButtonHeight: CGFloat = 40
        static var achievementsButtonWidth: CGFloat = 140
        static var achievementsButtonCornerRadius: CGFloat = 20
    }
}
