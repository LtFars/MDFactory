//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

protocol ProfilePresenterOutput: AnyObject {
     
    func provaidUserAchievements(_ achievements: [AchievementsModel]?)
    
}

class ProfileViewController: UIViewController {
    
    // MARK: - Elements
    
    var presenter: ProfilePresenterInput?
    
    private let sheetProfileView = SheetProfileView()
    
    private lazy var achievementsButton: UIButton = {
        var button = UIButton(type: .system)
        button.backgroundColor = Color.gray.color
        button.setTitle("Achievements", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = MetricConstraints.achievementsButtonCornerRadius
        button.addTarget(self,
                         action: #selector(showAchievements),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLoyaut()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = Color.purpl.color
    }
    
    // MARK: - Private functions
    
    @objc private func showAchievements() {
        presenter?.getUserAchievements()
    }
    
    private func setupHierarchy() {
        view.addSubview(sheetProfileView)
        view.addSubview(achievementsButton)
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
    
    // MARK: - Metrics
    
    enum MetricConstraints {
        static var sheetConstraintsLeadingBottomTrailing: CGFloat = 0
        static var achievementsCollectionTop: CGFloat = 50
        static var achievementsButtonTop: CGFloat = 150
        static var achievementsButtonHeight: CGFloat = UIScreen.main.bounds.width / 9
        static var achievementsButtonWidth: CGFloat = UIScreen.main.bounds.width / 3
        static var achievementsButtonCornerRadius: CGFloat = 20
    }
}

    // MARK: - ProfilePresenterOutput

extension ProfileViewController: ProfilePresenterOutput {
   
    func provaidUserAchievements(_ achievements: [AchievementsModel]?) {
        
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
        achievementsController.achievements = achievements
        if let sheet = achievementsController.sheetPresentationController {
            sheet.detents = [.large(), .medium()]
        }

        navigationController?.present(achievementsController, animated: true)
    }
}


