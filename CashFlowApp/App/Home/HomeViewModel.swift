import Foundation

protocol HomeViewModelInterface {
    var transactions: [Transaction] { get }

    func setupBalance()
    func showTransactionHistory()
}

final class HomeViewModel {
    private var transactionUseCase: TransactionUseCaseProtocol
    weak var view: HomeViewControllerInterface?
    weak var output: HomeOutput?
    
    init(
        output: HomeOutput?,
        transactionUseCase: TransactionUseCaseProtocol
    ) {
        self.output = output
        self.transactionUseCase = transactionUseCase
    }
}

extension HomeViewModel: HomeViewModelInterface {
    var transactions: [Transaction] {
        transactionUseCase.transactions
    }
    
    func showTransactionHistory() {
        output?.showTransactionHistory()
    }
    
    func setupBalance() {
        guard let model = transactionUseCase.balance?.toModel else { return }
        view?.setupHeader(
            with: .init(
                totalBalance: model.total,
                incomeValue: model.income,
                expensesValue: model.expenses
            )
        )
        
    }
}

extension HomeViewModel: HomeInput {
    func addedNewTransaction() {
        setupBalance()
        view?.reloadData()
    }
}
