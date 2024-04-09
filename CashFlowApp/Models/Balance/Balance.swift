import Foundation

struct Balance {
    var total: Int
    var income: Int
    var expenses: Int
}

extension Balance {
    var toRealm: BalanceRM {
        .init(total: total, income: income, expenses: expenses)
    }
}
