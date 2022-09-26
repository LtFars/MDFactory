//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    let achievements = AchievementsModel.mocks
    
    private let sheetProfileView = SheetProfileView()
    
    
    private let defaultHeight: CGFloat = UIScreen.main.bounds.height / 3.5
    private let dismissibleHeight: CGFloat = 100
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.9
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
    
    private lazy var achievementsLabel: UILabel = {
        var name = UILabel()
        name.text = "Achievements"
        name.font = .systemFont(ofSize: 21, weight: .medium)
        return name
    }()
    
    let maxDimmedAlpha: CGFloat = 0
    private lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        view.alpha = maxDimmedAlpha
        return view
    }()
    
    private lazy var achievementsCollectionView: UICollectionView = {
    
        let collection = UICollectionView(frame: UIScreen.main.bounds,
                                          collectionViewLayout:  createLayout())

        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProfileCollectionViewCell.self,
                            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        collection.isScrollEnabled = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setupHierarchy()
        setupLoyaut()
        setupPanGesture()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        achievementsCollectionView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
    }
    
    private func setupHierarchy() {
        view.addSubview(sheetProfileView)
        view.addSubview(dimmedView)
        view.addSubview(sheetImageView)
        view.addSubview(stripImageView)
        view.addSubview(backButton)
        sheetImageView.addSubview(achievementsLabel)
        sheetImageView.addSubview(achievementsCollectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let spacing: CGFloat = 16
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0 / 3.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: spacing,
                                   leading: spacing,
                                   bottom: spacing,
                                   trailing: spacing)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0 / 3.0))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item, count: 3)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 95,
                                      leading: spacing,
                                      bottom: spacing,
                                      trailing: spacing)
        
        section.interGroupSpacing = 30
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        
        return layout
    }
    
    private func setupLoyaut() {
        
        sheetProfileView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(0)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(20)
        }
        
        dimmedView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        sheetImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(0)
        }
        
        stripImageView.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.top).offset(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(3)
            make.width.equalTo(50)
        }
        
        achievementsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(39)
        }
        
        containerViewHeightConstraint = sheetImageView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
        
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0.6
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
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

//        animateShowDimmedView()
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

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configure(with: achievements[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cover = achievements[indexPath.row]
        print("selected \(cover.name)")
        
    }
}

