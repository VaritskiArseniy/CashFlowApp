import UIKit

protocol AddTransactionViewModelInterface {
    func addTransaction(transaction: Transaction)
    func showErrorAddAlert()
}

final class AddTransactionViewModel {
    private var transactionUseCase: TransactionUseCaseProtocol
    weak var view: AddTransactionViewController?
    weak var output: AddTransactionOutput?
    
    init(
        transactionUseCase: TransactionUseCaseProtocol,
        output: AddTransactionOutput?
    ) {
        self.transactionUseCase = transactionUseCase
        self.output = output
    }
}

extension AddTransactionViewModel: AddTransactionViewModelInterface {
    func addTransaction(transaction: Transaction) {
        updateBalance(transaction: transaction)
        transactionUseCase.addTransaction(transaction: transaction)
        output?.closeAfterAddTransaction()
    }
    
    func showErrorAddAlert() {
        view?.showAlert(
            title: "Failed to add transaction",
            message: "The entered data is incorrect",
            actions: [UIAlertAction(title: "Ok", style: .cancel)]
        )
    }
    
    private func updateBalance(transaction: Transaction) {
        guard var balance = transactionUseCase.balance?.toModel else { return }
        switch transaction.type {
        case .income:
            balance.income += transaction.amount
            balance.total += transaction.amount

        case .expenses:
            balance.expenses += transaction.amount
            balance.total -= transaction.amount
        }
        transactionUseCase.updateBalance(balance)
    }
}
