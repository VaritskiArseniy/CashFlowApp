import Foundation

struct Transaction: Identifiable {
    let id = UUID()
    var name: String
    var amount: Int
    var date: Date
    var type: TransactionType
}

extension Transaction {
    var toRealm: TransactionRM {
        .init(name: name, amount: amount, date: date, type: type.rawValue)
    }
}
