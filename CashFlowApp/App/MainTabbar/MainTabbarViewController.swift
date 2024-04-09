import UIKit

final class MainTabbarViewController: UITabBarController {
    
    private lazy var addButton = UIButton().then {
        $0.frame.size = .init(width: 75, height: 75)
        $0.setImage(.addIc, for: .normal)
        $0.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
    }
    
    private lazy var homeTabBarItem = UITabBarItem().then {
        $0.image = .homeIc
        $0.selectedImage = .homeSelectedIc.withTintColor(.c3F8782)
    }
    
    private lazy var statisticsTabBarItem = UITabBarItem().then {
        $0.image = .chartIc
        $0.selectedImage = .chartSelectedIc.withTintColor(.c3F8782)
    }
    
    private var controllers: [UIViewController]?
    private let viewModel: MainTabbarViewModelInterface
    
    init(controllers: [UIViewController], viewModel: MainTabbarViewModelInterface) {
        self.controllers = controllers
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupButton()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabBar.frame.size.height = 80
        tabBar.frame.origin.y = view.frame.height - 80
        tabBar.tintColor = .c3F8782
    }
    
    private func setup() {
        navigationItem.setHidesBackButton(true, animated: false)
        viewControllers = controllers
        
        tabBar.dropShadow()
        tabBar.backgroundColor = .white
    }
    
    private func setupButton() {
        view.addSubview(addButton)
        addButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
        }
    }
    
    @objc
    private func addTransaction() {
        viewModel.showAddTransaction()
    }
}
