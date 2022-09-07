import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private lazy var cellView: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
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
        contentView.addSubview(cellView)
        cellView.addSubview(image)
        cellView.addSubview(label)
    }
    
    func setupLayout() {
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        label.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(30)
            make.centerY.equalToSuperview()
        }
    }
    func configure() {
        label.text = "Text"
        image.image = UIImage(systemName: "person")
    }
}
