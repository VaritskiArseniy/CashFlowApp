import DGCharts
import Foundation

protocol StatisticsViewModelInterface {
    var topTransactionsDatasource: [TransactionTableViewCell.Model] { get }

    func configureChartModel(type: TransactionType) -> ChartViewModel
}

final class StatisticsViewModel {
    private var transactionUseCase: TransactionUseCaseProtocol
    weak var view: StatisticsViewControllerInterface?
    weak var output: StatisticsOutput?
    
    var topTransactionsDatasource = [TransactionTableViewCell.Model]()
    
    init(
        transactionUseCase: TransactionUseCaseProtocol,
        output: StatisticsOutput?
    ) {
        self.transactionUseCase = transactionUseCase
        self.output = output
    }
}

extension StatisticsViewModel: StatisticsViewModelInterface {
    func configureChartModel(type: TransactionType) -> ChartViewModel {
        let transactions = transactionUseCase.transactions.filter { $0.type == type }
        
        topTransactionsDatasource = configureTopTransaction(transactions: transactions)
        view?.reloadData()
        
        let daysRange = (1...8)
            .compactMap({ Calendar.current.date(byAdding: .day, value: -$0, to: .now)?.dateString.toDate })
            .sorted(by: <)
            .enumerated()
            .map { (index: $0 + 1, data: $1) }
        
        let data = Dictionary(grouping: transactions) { $0.date.dateString }
        
        let chartData = data.map({
            let value = $0.value.reduce(0) { result, item in
                result + item.amount
            }
            return (data: $0.key.toDate, value: value)
        })
        
        let chartDataEntries: [ChartDataEntry] = daysRange.map { rangeItem in
            let amount = chartData.first(where: { $0.data == rangeItem.data })?.value ?? .zero
            let x = Double(rangeItem.index)
            let y = Double(amount)
            return ChartDataEntry(x: x, y: y, data: rangeItem.data.dateString)
        }
        
        let chartDataSetOne = ChartDataSetVM(
            colorAsset: .main,
            chartDataEntries: chartDataEntries
        )
        return ChartViewModel(chartDataSetVMs: [chartDataSetOne])
    }

    private func configureTopTransaction(transactions: [Transaction]) -> [TransactionTableViewCell.Model] {
        let sevenDayAgoDate = Calendar.current.date(byAdding: .day, value: -7, to: .now)?.dateString.toDate ?? .now
        return transactions
            .filter({ $0.date > sevenDayAgoDate })
            .sorted(by: { $0.amount > $1.amount })
            .prefix(3)
            .map { .init(title: $0.name, date: $0.date, value: $0.amount, type: $0.type) }
    }
}
