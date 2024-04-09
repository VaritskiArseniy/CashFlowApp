import RealmSwift

class TransactionRM: Object {
    @Persisted var name: String
    @Persisted var amount: Int
    @Persisted var date: Date
    @Persisted var type: String
    
    convenience init(name: String, amount: Int, date: Date, type: String) {
        self.init()
        self.name = name
        self.amount = amount
        self.date = date
        self.type = type
    }
}

extension TransactionRM {
    var toModel: Transaction {
        .init(name: name, amount: amount, date: date, type: transactionType(type))
    }
    
    private func transactionType(_ type: String) -> TransactionType {
        guard type == "income" else { return .expenses }
        return .income
    }
}
