import UIKit

protocol TextFieldWithLabelDelegate: AnyObject {
    func shouldReturn(_ view: TextFieldWithLabel)
}

final class TextFieldWithLabel: UIStackView {
    
    weak var delegate: TextFieldWithLabelDelegate?
    var type: TextFieldWithLabelType = .text
    
    var title: String? {
        get {
            titleLabel.text
        } set {
            titleLabel.text = newValue
        }
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.textColor = .c666666
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    lazy var textField = MainTextField().then {
        $0.delegate = self
    }
    
    private lazy var datePicker = UIDatePicker().then {
        $0.timeZone = .current
        $0.datePickerMode = .date
        $0.preferredDatePickerStyle = .wheels
        $0.maximumDate = .now
        $0.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    private lazy var toolbar = UIToolbar().then {
        $0.sizeToFit()
        $0.items = [.init(barButtonSystemItem: .done, target: self, action: #selector(toolbarDone))]
    }
    
    init(type: TextFieldWithLabelType = .text) {
        super.init(frame: .zero)
        axis = .vertical
        spacing = 10
        addArrangedSubviews([titleLabel, textField])
        setup(with: type)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(with type: TextFieldWithLabelType) {
        self.type = type
        switch type {
        case .text:
            textField.placeholder = "Enter description"
        case .amount:
            textField.keyboardType = .numberPad
            textField.placeholder = "Enter amount"
            textField.inputAccessoryView = toolbar
        case .date:
            textField.placeholder = Date().dateString
            textField.inputAccessoryView = toolbar
        }
    }
    
    @objc
    private func datePickerValueChanged() {
        textField.text = datePicker.date.dateString
    }
    
    @objc
    private func toolbarDone() {
        delegate?.shouldReturn(self)
    
        guard
            type == .date,
            datePicker.date.dateString == Date().dateString
        else { return }
        textField.text = datePicker.date.dateString
    }
}

extension TextFieldWithLabel {
    enum TextFieldWithLabelType {
        case text
        case amount
        case date
    }
}

extension TextFieldWithLabel: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.shouldReturn(self)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textField.isActive = true
        switch type {
        case .date:
            textField.inputView = datePicker

        default:
            break
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.isActive = false
    }
}

extension Date {
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
