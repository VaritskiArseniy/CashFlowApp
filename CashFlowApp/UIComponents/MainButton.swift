import UIKit

final class MainButton: UIButton {
    var text: String? {
        get {
            title.text
        } set {
            title.text = newValue
        }
    }
    
    private var isLoaded = false
    
    private lazy var title = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    override public var isEnabled: Bool {
        didSet {
            if isEnabled { alpha = 1 } else { alpha = 0.3 }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        setupStyle()
    }
    
    private func setup() {
        layer.cornerRadius = 33
        addSubview(title)
    }
    
    private func setupConstraints() {
        snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        title.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupStyle() {
        guard !isLoaded else { return }
        let shadowLayer = CALayer().then {
            $0.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 33).cgPath
            $0.shadowColor = UIColor.c438883.cgColor
            $0.shadowOpacity = 0.7
            $0.shadowRadius = 33
            $0.position = CGPoint(x: .zero, y: 20)
        }

        let gradient = CAGradientLayer().then {
            $0.colors = [UIColor.c69AEA9.cgColor, UIColor.c3F8782.cgColor]
            $0.startPoint = CGPoint(x: 1, y: 0)
            $0.endPoint = CGPoint(x: 1, y: 1)
            $0.cornerRadius = 33
            $0.frame = bounds
        }
        layer.insertSublayer(shadowLayer, at: 0)
        layer.insertSublayer(gradient, at: 1)
        isLoaded.toggle()
    }
}
