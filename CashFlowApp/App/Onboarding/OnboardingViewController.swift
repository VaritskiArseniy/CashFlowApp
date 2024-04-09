import UIKit
import Then
import SnapKit

final class OnboardingViewController: UIViewController {
    private lazy var backgroundImage = UIImageView().then {
        $0.image = UIImage(resource: .background)
    }
    
    private lazy var personImage = UIImageView().then {
        $0.image = UIImage(resource: .person)
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Spend Smarter Save More"
        $0.textColor = .c438883
        $0.textAlignment = .center
        $0.numberOfLines = .zero
        $0.font = .systemFont(ofSize: 36, weight: .bold)
    }
    
    private lazy var continueButton = MainButton().then {
        $0.text = "Get Started"
        $0.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    private let viewModel: OnboardingViewModelInterface
    
    init(viewModel: OnboardingViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([backgroundImage, personImage, titleLabel, continueButton])
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        personImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64)
            $0.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(personImage.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(56)
        }
        
        continueButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    @objc
    private func continueButtonTapped() {
        viewModel.showBasePreferences()
    }
}
