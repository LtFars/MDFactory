import UIKit
import SnapKit

class MainPageCollectionViewCellList: UICollectionViewCell {
    static let identifier = "MainPageCollectionViewCellList"
    
    // MARK: - Elements
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
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
    
    private func setupHierarchy() {
        contentView.addSubview(cellView)
        cellView.addSubview(image)
        cellView.addSubview(stack)
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(sublabel)
    }
    
    private func setupLayout() {
        cellView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.height.width.equalTo(40)
            make.centerY.equalToSuperview()
        }
        stack.snp.makeConstraints { make in
            make.left.equalTo(image.snp.right).offset(30)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - MainPageCollectionViewCellProtocol

extension MainPageCollectionViewCellList: MainPageCollectionViewCellProtocol {
    func configure(cell: ItemForMain) {
        label.text = cell.title
        image.image = cell.image
        sublabel.text = cell.description
    }
}
