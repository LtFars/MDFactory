import UIKit
import SnapKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private lazy var cellView: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        return button
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "person")
        return image
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "123123eqweqwe"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
    }
    
    func setupHierarchy() {
        contentView.addSubview(cellView)
        cellView.addSubview(image)
        cellView.addSubview(label)
    }
    
    func setupLayout() {
        cellView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.width.equalToSuperview()
            make.height.equalTo(100)
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
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
