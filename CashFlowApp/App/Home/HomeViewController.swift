import UIKit

protocol HomeViewControllerInterface: AnyObject {
    func reloadData()
    func setupHeader(with model: HomeHeaderView.Model)
}

final class HomeViewController: UIViewController {
    private var headerView = HomeHeaderView()
    
    private let headerLabel = LabelWithButtonView(title: "Transactions history")
    
    private lazy var tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.showsVerticalScrollIndicator = false
        $0.bounces = false
        $0.delegate = self
        $0.dataSource = self
        $0.register(class: TransactionTableViewCell.self)
    }
    
    private let viewModel: HomeViewModelInterface
    
    init(viewModel: HomeViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        headerLabel.action = { [weak self] in
            self?.viewModel.showTransactionHistory()
        }
        setupUI()
        setupConstraints()
        viewModel.setupBalance()
    }
    
    private func setupUI() {
        view.addSubviews([headerView, headerLabel, tableView])
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(22)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(18)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HomeViewController: HomeViewControllerInterface {
    func reloadData() {
        tableView.reloadData()
    }
    
    func setupHeader(with model: HomeHeaderView.Model) {
        headerView.configure(with: model)
    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TransactionTableViewCell.self)
        let model = viewModel.transactions[indexPath.row]
        cell.configure(with: .init(title: model.name, date: model.date, value: model.amount, type: model.type))
        return cell
    }
    
    
}
