import UIKit
import SnapKit

class MainPageViewController: UIViewController {
    static let identifier = "MainPage"
    let userName = "User"
    lazy var layout = getLayout(flag: Model.gridMode)
    
    var model: [ItemForMain] = Model().itemForCollection()
    
    // MARK: - Top bar
    
    private let topBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = Metrics.topBarRadius
        return view
    }()
    
    private let greetingsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hex: Metrics.profileButtonColorHex)
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
        return button
    }()
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "user")
        return image
    }()
    
    @objc func openProfile() {
        self.tabBarController?.selectedIndex = 1
    }
    
    // MARK: - Bottom bar
    
    private let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Content
    
    private let conteinerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = Metrics.topBarRadius
        return view
    }()
    
    private var mainCollection: UICollectionView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Metrics.backgroungColorHex)
        navigationController?.navigationBar.isHidden = true
        configureCollectionView()
        mainCollection.dataSource = self
        setupHierachy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    func setupHierachy() {
        view.addSubview(topBar)
        topBar.addSubview(profileButton)
        profileButton.addSubview(profileImage)
        topBar.addSubview(greetingsLabel)
        topBar.addSubview(continueLabel)
        view.addSubview(bottomBar)
        view.addSubview(conteinerView)
        conteinerView.addSubview(mainCollection)
    }
    
    func setupLayout() {
        topBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(-(Metrics.topBarRadius / 2))
            make.height.equalTo(Metrics.topBarHeight)
        }
        
        profileButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Metrics.profileButtonTop)
            make.right.equalToSuperview().offset(Metrics.profileButtonRight)
            make.width.height.equalTo(Metrics.profileButtonSize)
        }
        
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.frame = profileButton.bounds
        greetingsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Metrics.greetingsLabelTop)
            make.left.equalToSuperview().offset(Metrics.greetingsLabelLeft)
            make.right.equalToSuperview().offset(-Metrics.greetingsLabelLeft)
        }
        
        greetingsLabel.text = "Hello \(userName),"
        continueLabel.snp.makeConstraints { make in
            make.top.equalTo(greetingsLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(Metrics.continueLabelLeft)
            make.right.equalToSuperview().offset(-Metrics.continueLabelLeft)
        }
        
        continueLabel.text = "Continue to learn Swift"
        bottomBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(Metrics.topBarRadius / 2)
            make.left.right.equalToSuperview()
            make.height.equalTo((navigationController?.tabBarController?.tabBar.frame.height ?? 0) + Metrics.topBarRadius * 2)
        }
        
        conteinerView.backgroundColor = view.backgroundColor
        conteinerView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomBar.snp.top).offset(Metrics.topBarRadius)
        }
        
        mainCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureCollectionView() {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            CollectionViewCellList.self,
            forCellWithReuseIdentifier: CollectionViewCellList.identifier
        )
        
        collectionView.register(
            CollectionViewCellGrid.self,
            forCellWithReuseIdentifier: CollectionViewCellGrid.identifier
        )
        
        collectionView.register(
            HeaderCollectionView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderCollectionView.identifier
        )
        
        collectionView.backgroundColor = .clear
        mainCollection = collectionView
    }
    
    func getLayout(flag: Bool) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        if flag {
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 15, right: 30)
            layout.itemSize = CGSize(
                width: (view.frame.size.width / 2) - 40,
                height: 200
            )
            
            layout.minimumLineSpacing = 15
            layout.headerReferenceSize = CGSize(
                width: view.frame.size.width,
                height: 90
            )
        } else {
            layout.scrollDirection = .vertical
            layout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 15, right: 30)
            layout.itemSize = CGSize(
                width: view.frame.size.width - 60,
                height: 95
            )
            
            layout.minimumLineSpacing = 15
            layout.headerReferenceSize = CGSize(
                width: view.frame.size.width,
                height: 90
            )
        }
        return layout
    }
}

// MARK: - Extensions

extension MainPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollection.dequeueReusableCell(
            withReuseIdentifier: Model.gridMode ? CollectionViewCellGrid.identifier : CollectionViewCellList.identifier,
            for: indexPath
        ) as? CollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(item: model[indexPath.row])
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = mainCollection.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderCollectionView.identifier,
                for: indexPath
            ) as? HeaderCollectionView else {
                return UICollectionReusableView()
            }
            header.configure()
            header.changeViewCollectionCompletion = { [unowned self] in
                layout = getLayout(flag: Model.gridMode)
                mainCollection.setCollectionViewLayout(layout, animated: true)
            }
            return header
        } else {
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}

// MARK: - Metrics

extension MainPageViewController {
    enum Metrics {
        static let topBarRadius: CGFloat = 40
        static let topBarHeight: CGFloat = 233 + 44
        static let backgroungColorHex: String = "#F2F6FCFF"
        static let profileButtonColorHex: String = "#E0E6F3FF"
        static let greetingsLabelLeft: CGFloat = 35
        static let greetingsLabelTop: CGFloat =  133 + 44
        static let continueLabelLeft: CGFloat = 35
        static let profileButtonSize: CGFloat = 43
        static let profileButtonRight: CGFloat = -30
        static let profileButtonTop: CGFloat = 77
        static let cellCount: CGFloat = 4
        static let containerHeight: CGFloat = cellCount * 110
    }
}

protocol CollectionViewCell: UICollectionViewCell {
    func configure(item: ItemForMain)
}
