import UIKit

protocol AddTransactionViewControllerInterface {}

final class AddTransactionViewController: UIViewController {
    private let headerView = UIImageView(image: .header)
    
    private lazy var backgoundView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.dropShadow()
    }
    
    private lazy var containerStack = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    private lazy var segmentControl = UISegmentedControl(items: ["Income", "Expenses"]).then {
        $0.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        $0.backgroundColor = .cF4F6F6
        $0.tintColor = .c666666
        $0.selectedSegmentTintColor = .white
        $0.selectedSegmentIndex = 1
    }
    
    private lazy var descriptionTextField = TextFieldWithLabel(type: .text).then {
        $0.title = "Description"
        $0.delegate = self
    }
    
    private lazy var amountTextField = TextFieldWithLabel(type: .amount).then {
        $0.title = "Amount"
        $0.delegate = self
    }
    
    private lazy var dateTextField = TextFieldWithLabel(type: .date).then {
        $0.title = "Date"
        $0.delegate = self
    }
    
    private lazy var addButton = MainButton().then {
        $0.text = "Add Transaction"
        $0.addTarget(self, action: #selector(addTransaction), for: .touchUpInside)
    }
    
    private var transactionType: TransactionType = .expenses
    private let viewModel: AddTransactionViewModelInterface
    
    init(viewModel: AddTransactionViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubviews([headerView, backgoundView, addButton])
        backgoundView.addSubview(containerStack)
        containerStack.addArrangedSubviews([segmentControl, descriptionTextField, amountTextField, dateTextField])
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        backgoundView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(48)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        containerStack.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        addButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaInsets.bottom).inset(32)
        }
    }
    
    private func setupShadow() {
        backgoundView.layer.shadowColor = UIColor.black.cgColor
        backgoundView.layer.shadowOpacity = 1
        backgoundView.layer.shadowOffset = .zero
        backgoundView.layer.shadowRadius = 10
        backgoundView.layer.shadowPath = UIBezierPath(rect: backgoundView.bounds).cgPath
        backgoundView.layer.shouldRasterize = true
    }
    
    @objc
    private func addTransaction() {
        guard 
            let description = descriptionTextField.textField.text,
            let amout = Int(amountTextField.textField.text ?? "0"),
            let date = dateTextField.textField.text?.toDate
        else { 
            viewModel.showErrorAddAlert()
            return
        }
        
        let transaction = Transaction(name: description, amount: amout, date: date, type: transactionType)
        viewModel.addTransaction(transaction: transaction)
    }
    
    @objc
    private func segmentControlChanged() {
        if segmentControl.selectedSegmentIndex == .zero {
            transactionType = .income
        } else {
            transactionType = .expenses
        }
    }
}

extension AddTransactionViewController: AddTransactionViewControllerInterface {
    
}

extension AddTransactionViewController: TextFieldWithLabelDelegate {
    func shouldReturn(_ view: TextFieldWithLabel) {
        switch view {
        case self.descriptionTextField:
            amountTextField.textField.becomeFirstResponder()
        case self.amountTextField:
            dateTextField.textField.becomeFirstResponder()
        default:
            dateTextField.textField.resignFirstResponder()
        }
    }
}

extension String {
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM yyyy"
        guard let date = dateFormatter.date(from: self) else { return .now }
        return date
    }
}
