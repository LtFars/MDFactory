import UIKit
import SnapKit

class HeaderCollectionView: UICollectionReusableView {
    static let identifier = "HeaderCollectionView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Metrics.titleFontSize, weight: .bold)
        return label
    }()
    
    private lazy var buttonRow: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Strings.listButtonImageName), for: .normal)
        button.imageView?.tintColor = UIColor(hex: Strings.imageColor)
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.addTarget(self, action: #selector(changeMode(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonGrid: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Strings.gridButtonImageName), for: .normal)
        button.imageView?.tintColor = UIColor(hex: Strings.imageColor)
        button.layer.cornerRadius = Metrics.buttonCornerRadius
        button.addTarget(self, action: #selector(changeMode(_:)), for: .touchUpInside)
        return button
    }()
    
    var changeViewCollectionCompletion: (() -> Void)?
    
    // MARK: - Lifecycle
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    func setupHierarchy() {
        addSubview(label)
        addSubview(buttonRow)
        addSubview(buttonGrid)
    }
    
    func setupLayout() {
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
        }
        buttonRow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-30)
            make.height.width.equalTo(Metrics.buttonHeight)
        }
        buttonGrid.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(buttonRow.snp.left).offset(-5)
            make.height.width.equalTo(Metrics.buttonHeight)
        }
    }
    
    func configure() {
        label.text = Strings.headerTitle
        changeMode()
    }
    
    func changeMode() {
        if MainPageModel.gridMode {
            buttonRow.backgroundColor = UIColor(hex: Strings.deselectedBGColor)
            buttonGrid.backgroundColor = UIColor(hex: Strings.selectedBGColor)
            changeViewCollectionCompletion?()
        } else {
            buttonGrid.backgroundColor = UIColor(hex: Strings.deselectedBGColor)
            buttonRow.backgroundColor = UIColor(hex: Strings.selectedBGColor)
            changeViewCollectionCompletion?()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    @objc func changeMode(_ sender: UIButton) {
        if sender == buttonGrid {
            MainPageModel.gridMode = true
        } else {
            MainPageModel.gridMode = false
        }
        changeMode()
    }
}

extension HeaderCollectionView {
    enum Strings {
        static let headerTitle = "Your Lessons"
        static let listButtonImageName = "rectangle.grid.1x2.fill"
        static let gridButtonImageName = "circle.grid.2x2.fill"
        static let imageColor = "#9DA8C3FF"
        static let selectedBGColor = "#E0E6F3FF"
        static let deselectedBGColor = "#00000000"
    }
    
    enum Metrics {
        static let titleFontSize: CGFloat = 21
        static let buttonCornerRadius: CGFloat = 11
        static let buttonHeight: CGFloat = 40
    }
}
