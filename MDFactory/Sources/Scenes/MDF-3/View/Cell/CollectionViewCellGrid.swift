import UIKit
import SnapKit

class CollectionViewCellGrid: UICollectionViewCell, CollectionViewCell {
    static let identifier = "CollectionViewCellGrid"
    
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
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private let sublabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
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
        cellView.addSubview(stack)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(sublabel)
    }
    
    func setupLayout() {
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.height.width.equalTo(40)
            make.top.equalToSuperview().offset(30)
        }
        stack.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.top.equalTo(image.snp.bottom).offset(10)
            make.width.equalToSuperview().offset(-10)
        }
    }
    
    func configure(item: ItemForMain) {
        label.text = item.title
        image.image = item.image
        sublabel.text = item.description
    }
}

