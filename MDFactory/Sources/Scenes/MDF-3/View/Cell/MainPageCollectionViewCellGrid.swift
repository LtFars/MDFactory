import UIKit
import SnapKit

protocol MainPageCollectionViewCellProtocol: UICollectionViewCell {
     func configure(cell: ItemForMain)
 }

class MainPageCollectionViewCellGrid: UICollectionViewCell {
    static let identifier = "MainPageCollectionViewCellGrid"
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
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
}

// MARK: - MainPageCollectionViewCellProtocol

extension MainPageCollectionViewCellGrid: MainPageCollectionViewCellProtocol {
    func configure(cell: ItemForMain) {
        label.text = cell.title
        image.image = cell.image
        sublabel.text = cell.description
    }
}
