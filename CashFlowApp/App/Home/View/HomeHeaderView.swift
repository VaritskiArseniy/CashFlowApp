import UIKit

final class HomeHeaderView: UIView {
    private let backgroundView = UIImageView(image: .header)
    
    private lazy var containerStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    private lazy var balanceContainerStack = UIStackView().then {
        $0.axis = .vertical
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "Total balance"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    private lazy var balanceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 30, weight: .bold)
        $0.textColor = .white
    }
    
    private lazy var incomeExpensesContainerStack = UIStackView().then {
        $0.distribution = .fillEqually
        $0.alignment = .center
    }
    
    private let incomeView = IncomeExpensesView()
    
    private let expensesView = IncomeExpensesView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(backgroundView)
        backgroundView.addSubview(containerStack)
        containerStack.addArrangedSubviews([balanceContainerStack, incomeExpensesContainerStack])
        balanceContainerStack.addArrangedSubviews([titleLabel, balanceLabel])
        incomeExpensesContainerStack.addArrangedSubviews([incomeView, expensesView])
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        containerStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(64)
            $0.bottom.equalToSuperview().inset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func configure(with model: Model) {
        balanceLabel.text = "$ \(model.totalBalance)"
        incomeView.configure(with: .income(model.incomeValue))
        expensesView.configure(with: .expenses(model.expensesValue))
    }
}

extension HomeHeaderView {
    struct Model {
        var totalBalance: Int
        var incomeValue: Int
        var expensesValue: Int
    }
}
