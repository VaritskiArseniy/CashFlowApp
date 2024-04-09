import UIKit

final class LabelWithButtonView: UIStackView {
    var action: (() -> Void)?
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .c222222
    }
    
    private lazy var button = UIButton().then {
        $0.setTitle("See all", for: .normal)
        $0.setTitleColor(.c666666, for: .normal)
        $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        distribution = .equalCentering
        addArrangedSubviews([titleLabel, button])
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func buttonTapped() {
        action?()
    }
}
