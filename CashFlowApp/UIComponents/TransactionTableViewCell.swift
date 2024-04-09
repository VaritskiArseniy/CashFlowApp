import Foundation
import UIKit

final class TransactionTableViewCell: UITableViewCell {
    private lazy var containerStack = UIStackView().then {
        $0.distribution = .equalCentering
    }
    
    private lazy var verticalContainerStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 6
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .black
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        $0.textColor = .c666666
    }
    
    private lazy var valueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(containerStack)
        containerStack.addArrangedSubviews([verticalContainerStack, valueLabel])
        verticalContainerStack.addArrangedSubviews([titleLabel, dateLabel])
    }
    
    private func setupConstraints() {
        containerStack.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(22)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        dateLabel.text = model.dateString
        valueLabel.text = "\(model.type.symbol) $ \(model.value)"
        valueLabel.textColor = model.type.color
    }
}

extension TransactionTableViewCell {
    struct Model {
        var title: String
        var date: Date
        var value: Int
        var type: TransactionType
        
        var dateString: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, y"
            return dateFormatter.string(from: date)
        }
    }
}
