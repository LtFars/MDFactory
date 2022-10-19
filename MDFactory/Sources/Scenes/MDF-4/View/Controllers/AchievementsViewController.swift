//
//  AchievementsViewController.swift
//  MDFactory
//
//  Created by Andrei Maskal on 12/10/2022.
//

import UIKit

class AchievementsViewController: UIViewController {
    
    var achievements: [AchievementsModel]?
    
    lazy var stripImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = MetricConstraints.cornerRadiusStripImage
        imageView.backgroundColor = Color.gray.color
        return imageView
    }()
    
    private lazy var stripButton: UIButton = {
        var button = UIButton(type: .system)
        button.addTarget(self, action: #selector(putSheet), for: .allTouchEvents)
        return button
    }()
    
    lazy var achievementsNameLabel: UILabel = {
        var name = UILabel()
        name.text = "Achievements"
        name.font = .systemFont(ofSize: 21, weight: .medium)
        return name
    }()
    
    lazy var achievementsCollectionView: UICollectionView = {
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
    
    @objc func putSheet() {
        dismiss(animated: true)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        setupLoyaut()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        achievementsCollectionView.frame = view.bounds.offsetBy(dx: 0, dy: MetricConstraints.achievementsCollectionTop)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = Metric.cornerRadiusView
    }
    
    private func setupHierarchy() {
        view.addSubview(achievementsCollectionView)
        view.addSubview(stripImageView)
        view.addSubview(achievementsNameLabel)
        view.addSubview(stripButton)
    }
    
    private func setupLoyaut() {
        
        achievementsCollectionView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(0)
        }
        
        stripImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(MetricConstraints.stripTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(MetricConstraints.stripHeight)
            make.width.equalTo(MetricConstraints.stripWidth)
        }
        
        stripButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(MetricConstraints.stripTop)
            make.centerX.equalToSuperview()
            make.height.equalTo(MetricConstraints.stripHeight)
            make.width.equalTo(MetricConstraints.stripWidth)
        }
        
        achievementsNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(MetricConstraints.achievementsNameTop)
        }
    }
    
    enum MetricConstraints {
        static var sheetConstraintsLeadingBottomTrailing: CGFloat = 0
        static var stripHeight: CGFloat = 6
        static var stripWidth: CGFloat = UIScreen.main.bounds.width / 8
        static var stripTop: CGFloat = 14
        static var achievementsNameTop: CGFloat = 39
        static var cornerRadiusStripImage: CGFloat = 2
        static var achievementsCollectionTop: CGFloat = 50
    }
    
    enum MetricCollectionView {
        static var spacing: CGFloat = 16
        static var spacingGroup: CGFloat = 30
    }
    
}

extension AchievementsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return achievements?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let cover = achievements?[indexPath.row]
        print("selected \(String(describing: cover?.name))")
    }
}

extension AchievementsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfileCollectionViewCell.identifier,
            for: indexPath
        ) as? ProfileCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
        let model = achievements?[indexPath.row]
        cell.configure(with: model ?? AchievementsModel(name: "", icon: ""))
        return cell
    }
}
