//
//  ProfilViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 01/09/2022.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    private let achievements = AchievementsModel.mocks
    private let sheetProfileView = SheetProfileView()
    
    private let defaultHeight: CGFloat = UIScreen.main.bounds.height / 3.5
    private let dismissibleHeight: CGFloat = 100
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.5
    private var currentContainerHeight: CGFloat = 100
    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?
    
    private lazy var sheetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9647058824, blue: 0.9882352941, alpha: 1)
        imageView.layer.cornerRadius = MetricConstraints.cornerRadiusSheetImage
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var stripImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = MetricConstraints.cornerRadiusStripImage
        imageView.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.9019607843, blue: 0.9529411765, alpha: 1)
        return imageView
    }()
    
    private lazy var achievementsNameLabel: UILabel = {
        var name = UILabel()
        name.text = "Achievements"
        name.font = .systemFont(ofSize: 21, weight: .medium)
        return name
    }()
    
    private lazy var achievementsCollectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout:  createLayout())
        collection.backgroundColor = .clear
        collection.delegate = self
        collection.dataSource = self
        collection.register(ProfileCollectionViewCell.self,
                            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        collection.isScrollEnabled = true
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
    
    private func setupHierarchy() {
        view.addSubview(sheetProfileView)
        view.addSubview(sheetImageView)
        view.addSubview(stripImageView)
        sheetImageView.addSubview(achievementsCollectionView)
        sheetImageView.addSubview(achievementsNameLabel)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        
        let spacing: CGFloat = MetricCollectionView.spacing
        
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
        section.contentInsets = .init(top: 15,
                                      leading: spacing,
                                      bottom: spacing,
                                      trailing: spacing)
        
        section.interGroupSpacing = MetricCollectionView.spacingGroup
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        layout.configuration.scrollDirection = .vertical
        
        return layout
    }
    
    private func setupLoyaut() {
        
        sheetProfileView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(MetricConstraints.sheetConstraintsLeadingBottomTrailing)
        }
        
        achievementsCollectionView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(0)
            make.top.equalTo(MetricConstraints.achievementsCollectionTop)
            
        }
        
        sheetImageView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(MetricConstraints.sheetConstraintsLeadingBottomTrailing)
        }
        
        stripImageView.snp.makeConstraints { make in
            make.top.equalTo(sheetImageView.snp.top).offset(MetricConstraints.stripTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(MetricConstraints.stripHeight)
            make.width.equalTo(MetricConstraints.stripWidth)
        }
        
        achievementsNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(MetricConstraints.achievementsNameTop)
        }
        
        containerViewHeightConstraint = sheetImageView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
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
        
        let translation = gesture.translation(in: sheetImageView)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        switch gesture.state {
            
        case .changed:
            if newHeight < maximumContainerHeight {
                containerViewHeightConstraint?.constant = newHeight
            }
            
        case .ended:
            if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
                sheetImageView.isUserInteractionEnabled = false
            }
            
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
                sheetImageView.isUserInteractionEnabled = true
            }
            
        default: break
        }
    }
    
    @objc func tabActiohButton() {
        dismiss(animated: true)
    }
    
    enum MetricConstraints {
        static var sheetConstraintsLeadingBottomTrailing: CGFloat = 0
        static var stripHeight: CGFloat = 3
        static var stripWidth: CGFloat = UIScreen.main.bounds.width / 9
        static var stripTop: CGFloat = 14
        static var achievementsNameTop: CGFloat = 39
        static var cornerRadiusSheetImage: CGFloat = 40
        static var cornerRadiusStripImage: CGFloat = 2
        static var achievementsCollectionTop: CGFloat = 50
    }
    
    enum MetricCollectionView {
        static var spacing: CGFloat = 16
        static var spacingGroup: CGFloat = 30
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cover = achievements[indexPath.row]
        print("selected \(cover.name)")
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCollectionViewCell.identifier,
            for: indexPath
        ) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
        let model = achievements[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}
