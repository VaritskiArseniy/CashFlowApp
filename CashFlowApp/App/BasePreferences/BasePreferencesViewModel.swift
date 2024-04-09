import Foundation

protocol BasePreferencesViewModelInterface {
    func showMain(_ value: String?)
}

final class BasePreferencesViewModel {
    private var transactionUseCase: TransactionUseCaseProtocol
    weak var output: BasePreferencesOutput?
    
    init(
        output: BasePreferencesOutput?,
        transactionUseCase: TransactionUseCaseProtocol
    ) {
        self.output = output
        self.transactionUseCase = transactionUseCase
    }
}

extension BasePreferencesViewModel: BasePreferencesViewModelInterface {
    func showMain(_ value: String?) {
        guard
            let value,
            let totalBalance = Int(value)
        else { return }
        let balance = Balance(total: totalBalance, income: .zero, expenses: .zero)
        transactionUseCase.setupBaseBalance(balance: balance)
        output?.showMain()
        UserDefaults.standard.setValue(true, forKey: "isLaunchBefore")
    }
}
