import UIKit

final class MainTextField: UITextField {
    var isActive: Bool = false {
        didSet {
            font = .systemFont(ofSize: 14, weight: isActive ? .semibold : .medium)
            textColor = isActive ? .c438883 : .c666666
            layer.borderColor = isActive ? UIColor.c438883.cgColor : UIColor.cDDDDDD.cgColor
            layer.borderWidth = isActive ? 1.4 : 1
        }
    }
    
    private var textPadding = UIEdgeInsets(
        top: 16,
        left: 20,
        bottom: 16,
        right: 20
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
                return rect.inset(by: textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    private func setup() {
        font = .systemFont(ofSize: 14, weight: .medium)
        textColor = .c666666
        layer.borderColor = UIColor.cDDDDDD.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        tintColor = .c438883
        delegate = self
    }
}

extension MainTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isActive = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isActive = false
    }
}
