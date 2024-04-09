import UIKit

// MARK: - TransactionHistoryViewController

final class TransactionHistoryViewController: UIViewController {
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.dataSource = self
        $0.register(class: TransactionTableViewCell.self)
    }
    
    private let viewModel: TransactionHistoryViewModelInterface
    
    init(viewModel: TransactionHistoryViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Transaction history"
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension TransactionHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TransactionTableViewCell.self)
        let model = viewModel.configureCellModel(index: indexPath)
        cell.configure(with: model)
        return cell
    }
}
