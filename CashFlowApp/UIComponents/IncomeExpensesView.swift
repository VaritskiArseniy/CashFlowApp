import UIKit

final class IncomeExpensesView: UIView {
    private lazy var containerStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 6
    }

    private lazy var headerContainerStack = UIStackView().then {
        $0.spacing = 6
    }
    
    private let iconView = UIImageView()
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .cD0E5E4
    }
    
    private lazy var valueLabel = UILabel().then {
        $0.text = "$ 0"
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerStack)
        containerStack.addArrangedSubviews([headerContainerStack, valueLabel])
        headerContainerStack.addArrangedSubviews([iconView, titleLabel])
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconView.snp.makeConstraints {
            $0.size.equalTo(24)
        }
    }
    
    func configure(with type: ViewType) {
        switch type {
        case .income:
            containerStack.alignment = .leading
        case .expenses:
            containerStack.alignment = .trailing
        }
        titleLabel.text = type.title
        iconView.image = type.icon
        valueLabel.text = "$ \(type.value)"
    }
}

extension IncomeExpensesView {
    enum ViewType {
        case income(Int)
        case expenses(Int)
        
        var title: String {
            switch self {
            case .income:
                "Income"
            
            case .expenses:
                "Expenses"
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .income:
                    .incomeIc

            case .expenses:
                    .expensesIc
            }
        }
        
        var value: Int {
            switch self {
            case .income(let value), .expenses(let value):
                value
            }
        }
    }
}
