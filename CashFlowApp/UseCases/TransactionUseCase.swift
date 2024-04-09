import Foundation

protocol TransactionUseCaseProtocol {
    var balance: BalanceRM? { get }
    var transactions: [Transaction] { get }

    func setupBaseBalance(balance: Balance)
    func updateBalance(_ newBalance: Balance)
    func addTransaction(transaction: Transaction)
    
}

final class TransactionUseCase {
    let realmManager: RealmManagerProtocol
    
    init(realmManager: RealmManagerProtocol) {
        self.realmManager = realmManager
    }
}

extension TransactionUseCase: TransactionUseCaseProtocol {
    var balance: BalanceRM? {
        let collection = realmManager.fetchCollection(BalanceRM.self)
        guard let balance = collection.first as? BalanceRM else { return nil }
        return balance
    }
    
    var transactions: [Transaction] {
        let collection = realmManager.fetchCollection(TransactionRM.self)
        let transactions: [Transaction] = collection.compactMap ({
            let object = $0 as? TransactionRM
            return object?.toModel
        }).sorted { $0.date > $1.date }
        return transactions
    }

    func addTransaction(transaction: Transaction) {
        let object = transaction.toRealm
        realmManager.create(object)
    }
    
    func setupBaseBalance(balance: Balance) {
        let object = balance.toRealm
        realmManager.create(object)
    }
        
    func updateBalance(_ newBalance: Balance) {
        guard let balance else { return }
        realmManager.delete(balance)
        let object = newBalance.toRealm
        realmManager.create(object)
    }
}
