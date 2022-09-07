import UIKit
import SnapKit

class HeaderCollectionView: UICollectionReusableView {
    static let identifier = "HeaderCollectionView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 21, weight: .bold)
        return label
    }()
    
    private lazy var buttonRow: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "rectangle.grid.1x2.fill"), for: .normal)
        button.imageView?.tintColor = UIColor(hex: "#9DA8C3FF")
        button.layer.cornerRadius = 11
        button.addTarget(self, action: #selector(changeMode(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonGrid: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "circle.grid.2x2.fill"), for: .normal)
        button.imageView?.tintColor = UIColor(hex: "#9DA8C3FF")
        button.layer.cornerRadius = 11
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
        //configure()
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
            make.height.width.equalTo(40)
        }
        buttonGrid.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(buttonRow.snp.left).offset(-5)
            make.height.width.equalTo(40)
        }
    }
    
    func configure() {
        label.text = "Your Lessons"
//        changeMode()
    }
    
//    func changeMode() {
//        if Model.gridMode {
//            buttonRow.backgroundColor = UIColor(hex: "#00000000")
//            buttonGrid.backgroundColor = UIColor(hex: "#E0E6F3FF")
//            // тут бы сменить layout коллекции
//        } else {
//            buttonGrid.backgroundColor = UIColor(hex: "#00000000")
//            buttonRow.backgroundColor = UIColor(hex: "#E0E6F3FF")
//            // тут бы сменить layout коллекции
//        }
//    }
    
    @objc func changeMode(_ sender: UIButton) {
//        if sender == buttonGrid {
//            Model.gridMode = true
//        } else {
//            Model.gridMode = false
//        }
//        changeMode()
        changeViewCollectionCompletion?()
    }
}
