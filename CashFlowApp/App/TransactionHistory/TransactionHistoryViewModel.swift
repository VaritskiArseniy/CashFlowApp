import Foundation

// MARK: - TransactionHistoryViewModelInterface

protocol TransactionHistoryViewModelInterface {
    var transactions: [Transaction] { get }
    
    func configureCellModel(index: IndexPath) -> TransactionTableViewCell.Model
}

// MARK: - TransactionHistoryViewModel

final class TransactionHistoryViewModel {
    private var transactionUseCase: TransactionUseCaseProtocol
    weak var output: TransactionHistoryOutput?
    
    init(
        transactionUseCase: TransactionUseCaseProtocol,
        output: TransactionHistoryOutput?
    ) {
        self.transactionUseCase = transactionUseCase
        self.output = output
    }
}

// MARK: - TransactionHistoryViewModelInterface

extension TransactionHistoryViewModel: TransactionHistoryViewModelInterface {
    var transactions: [Transaction] {
        transactionUseCase.transactions
    }
    
    func configureCellModel(index: IndexPath) -> TransactionTableViewCell.Model {
        let model = transactions[index.row]
        return .init(title: model.name, date: model.date, value: model.amount, type: model.type)
    }
    
    func close() {
        output?.close()
    }
}
