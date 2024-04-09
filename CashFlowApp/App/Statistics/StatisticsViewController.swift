import UIKit
import DGCharts

protocol StatisticsViewControllerInterface: AnyObject {
    func reloadData()
}

final class StatisticsViewController: UIViewController {
    private var menuChildren: [UIMenuElement] {
        [makeIncomeChart, makeExpensesChart]
    }
    
    private var makeIncomeChart: UIAction {
        UIAction(title: "Income") { [weak self] _ in
            self?.chartView.viewModel = self?.viewModel.configureChartModel(type: .income)
        }
    }
    
    private var makeExpensesChart: UIAction {
        UIAction(title: "Expenses", state: .on) { [weak self] _ in
            self?.chartView.viewModel = self?.viewModel.configureChartModel(type: .expenses)
        }
    }
    
    private lazy var menuButton = UIButton().then {
        $0.setTitleColor(.c666666, for: .normal)
        $0.setImage(.chevronDownIc, for: .normal)
        $0.menu = UIMenu(options: .displayInline, children: menuChildren)
        $0.showsMenuAsPrimaryAction = true
        $0.changesSelectionAsPrimaryAction = true
        $0.layer.borderColor = UIColor.c666666.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
    }
    
    private lazy var chartView = ChartView().then {
        $0.viewModel = viewModel.configureChartModel(type: .expenses)
    }
    
    private lazy var topTransactionsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.textColor = .c222222
        $0.text = "Top Transactions"
    }
    
    private lazy var tableView = UITableView().then {
        $0.isScrollEnabled = false
        $0.separatorStyle = .none
        $0.dataSource = self
        $0.register(class: TransactionTableViewCell.self)
    }
    
    private let viewModel: StatisticsViewModelInterface
    
    init(viewModel: StatisticsViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupChart()
    }
    
    private func setupChart() {
        chartView.viewModel = viewModel.configureChartModel(type: .expenses)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews([menuButton, chartView, topTransactionsLabel, tableView])
    }
    
    private func setupConstraints() {
        menuButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            $0.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(40)
            $0.width.equalTo(120)
        }
        
        chartView.snp.makeConstraints {
            $0.top.equalTo(menuButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        topTransactionsLabel.snp.makeConstraints {
            $0.top.equalTo(chartView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(22)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(topTransactionsLabel.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func reloadChart(type: TransactionType) {
        chartView.viewModel = viewModel.configureChartModel(type: type)
    }
    
    @objc
    private func showIncomeChart() {
        chartView.viewModel = viewModel.configureChartModel(type: .income)
    }
    
    @objc
    private func showExpensesChart() {
        chartView.viewModel = viewModel.configureChartModel(type: .expenses)
    }
}

extension StatisticsViewController: StatisticsViewControllerInterface {
    func reloadData() {
        tableView.reloadData()
    }
}

extension StatisticsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.topTransactionsDatasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(reusable: TransactionTableViewCell.self)
        let model = viewModel.topTransactionsDatasource[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}
