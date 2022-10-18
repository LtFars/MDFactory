import UIKit
import SnapKit

class CollectionViewCellGrid: UICollectionViewCell, CollectionViewCellProtocol {
    static let identifier = "CollectionViewCellGrid"
    
    private lazy var cellView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        return view
        view.backgroundColor = .white
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
    
    func configure(itemIndex: Int) {
        label.text = MainPagePresenter().getItemTitle(index: itemIndex)
        image.image = MainPagePresenter().getItemImage(index: itemIndex)
        sublabel.text = MainPagePresenter().getItemDescription(index: itemIndex)
    }
}

