import UIKit
import SnapKit

class MainPageViewController: UIViewController {
    
    private let userName = "User"
    private lazy var layout = getLayout(flag: MainPageModel.gridMode)
    private var model = MainPageModel.itemForCollection()
    var presenter: MainPageViewControllerOutput?
    
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
        label.font = .systemFont(ofSize: Metrics.greetingsLabelFontSize)
        return label
    }()
    
    private let continueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: Metrics.continueLabelFontSize, weight: .bold)
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
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = .systemFont(ofSize: Metrics.headerTitleFontSize, weight: .bold)
        label.text = Strings.headerTitle
        return label
    }()
    
    private lazy var buttonRow: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Strings.listButtonImageName), for: .normal)
        button.imageView?.tintColor = UIColor(hex: Strings.imageColor)
        button.layer.cornerRadius = Metrics.headerButtonCornerRadius
        button.addTarget(self, action: #selector(changeMode(_:)), for: .touchUpInside)
        button.backgroundColor = MainPageModel.gridMode ? UIColor(hex: Strings.deselectedBGColor) : UIColor(hex: Strings.selectedBGColor)
        return button
    }()
    
    private lazy var buttonGrid: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: Strings.gridButtonImageName), for: .normal)
        button.imageView?.tintColor = UIColor(hex: Strings.imageColor)
        button.layer.cornerRadius = Metrics.headerButtonCornerRadius
        button.addTarget(self, action: #selector(changeMode(_:)), for: .touchUpInside)
        button.backgroundColor = MainPageModel.gridMode ? UIColor(hex: Strings.selectedBGColor) : UIColor(hex: Strings.deselectedBGColor)
        return button
    }()
    
    @objc func changeMode(_ sender: UIButton) {
        MainPageModel.gridMode = sender == buttonGrid ? true : false
        layout = getLayout(flag: MainPageModel.gridMode)
        if MainPageModel.gridMode {
            buttonRow.backgroundColor = UIColor(hex: Strings.deselectedBGColor)
            buttonGrid.backgroundColor = UIColor(hex: Strings.selectedBGColor)
        } else {
            buttonGrid.backgroundColor = UIColor(hex: Strings.deselectedBGColor)
            buttonRow.backgroundColor = UIColor(hex: Strings.selectedBGColor)
        }
        self.mainCollection.reloadItems(at: self.mainCollection.indexPathsForVisibleItems)
        self.mainCollection.setCollectionViewLayout(layout, animated: true)
    }
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: Metrics.backgroungColorHex)
        configureCollectionView()
        mainCollection.delegate = self
        mainCollection.dataSource = self
        setupHierachy()
        setupLayout()
    }
    
    // MARK: - Settings
    
    private func setupHierachy() {
        view.addSubview(topBar)
        topBar.addSubview(profileButton)
        profileButton.addSubview(profileImage)
        topBar.addSubview(greetingsLabel)
        topBar.addSubview(continueLabel)
        view.addSubview(bottomBar)
        view.addSubview(conteinerView)
        conteinerView.addSubview(mainCollection)
        mainCollection.addSubview(headerLabel)
        mainCollection.addSubview(buttonRow)
        mainCollection.addSubview(buttonGrid)
    }
    
    private func setupLayout() {
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
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(Metrics.tabBarHeight)
        }
        
        conteinerView.backgroundColor = view.backgroundColor
        conteinerView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(bottomBar.snp.top)
        }
        
        mainCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.left.equalToSuperview().offset(35)
        }
        
        buttonRow.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.width.equalTo(Metrics.buttonHeight)
        }
        
        buttonGrid.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalTo(buttonRow.snp.left).offset(-5)
            make.height.width.equalTo(Metrics.buttonHeight)
        }
    }
    
    private func configureCollectionView() {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        collectionView.register(
            MainPageCollectionViewCellList.self,
            forCellWithReuseIdentifier: MainPageCollectionViewCellList.identifier
        )
        
        collectionView.register(
            MainPageCollectionViewCellGrid.self,
            forCellWithReuseIdentifier: MainPageCollectionViewCellGrid.identifier
        )
        
        collectionView.backgroundColor = .clear
        collectionView.isUserInteractionEnabled = true
        mainCollection = collectionView
    }
    
    private func getLayout(flag: Bool) -> UICollectionViewFlowLayout {
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

// MARK: - UICollectionViewDataSource

extension MainPageViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainCollection.dequeueReusableCell(
            withReuseIdentifier: MainPageModel.gridMode ? MainPageCollectionViewCellGrid.identifier : MainPageCollectionViewCellList.identifier,
            for: indexPath
        ) as? MainPageCollectionViewCellProtocol else {
            return UICollectionViewCell()
        }
        let model = model[indexPath.row]
        cell.configure(cell: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MainPageViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = model[indexPath.item].title
        model[indexPath.item].handler(title)
    }
}

// MARK: - MainPageViewControllerInput

extension MainPageViewController: MainPageViewControllerInput {
    
}

// MARK: - Metrics

extension MainPageViewController {
    
    enum Strings {
        static let headerTitle = "Your Lessons"
        static let listButtonImageName = "rectangle.grid.1x2.fill"
        static let gridButtonImageName = "circle.grid.2x2.fill"
        static let imageColor = "#9DA8C3FF"
        static let selectedBGColor = "#E0E6F3FF"
        static let deselectedBGColor = "#00000000"
    }
    
    enum Metrics {
        static var tabBarHeight: CGFloat = 98
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
        static let greetingsLabelFontSize: CGFloat = 20
        static let continueLabelFontSize: CGFloat = 28
        static let headerTitleFontSize: CGFloat = 21
        static let headerButtonCornerRadius: CGFloat = 11
        static let buttonHeight: CGFloat = 40
    }
}
