import UIKit

final class BasePreferencesViewController: UIViewController {
    private lazy var titleLabel = UILabel().then {
        $0.text = "Setup your balance"
        $0.font = .systemFont(ofSize: 36, weight: .medium)
        $0.textColor = .c438883
    }
    
    private lazy var inputTextField = MainTextField().then {
        $0.placeholder = "Balance"
        $0.keyboardType = .numberPad
    }
    
    private lazy var continueButton = MainButton().then {
        $0.text = "Continue"
        $0.addTarget(self, action: #selector(goToMain), for: .touchUpInside)
    }
    
    private let viewModel: BasePreferencesViewModelInterface
    
    init(viewModel: BasePreferencesViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
        view.addSubviews([titleLabel, inputTextField, continueButton])
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        continueButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }
    
    @objc
    private func goToMain() {
        viewModel.showMain(inputTextField.text)
    }
}
