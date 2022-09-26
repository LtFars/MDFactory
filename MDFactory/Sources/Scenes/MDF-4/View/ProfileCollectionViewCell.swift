//
//  ProfileCollectionViewCell.swift
//  MDFactory
//
//  Created by Andrei Maskal on 25/09/2022.
//

import UIKit
import SnapKit

class ProfileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ProfileCollectionViewCell"

    private lazy var imageAchievementsView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()

    private lazy var nameAchievementsLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textColor = #colorLiteral(red: 0.5509841442, green: 0.5953412652, blue: 0.6925969124, alpha: 1)
        return title
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageAchievementsView)
        addSubview(nameAchievementsLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayout()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: AchievementsModel) {
        imageAchievementsView.image = UIImage(named: model.icon)
        nameAchievementsLabel.text = model.name
    }

    private func setupLayout() {
        
        imageAchievementsView.frame = contentView.bounds
        
        nameAchievementsLabel.snp.makeConstraints { make in
            make.centerX.equalTo(imageAchievementsView.snp.centerX)
            make.top.equalTo(imageAchievementsView.snp.bottom).offset(12)
        }
    }
}
