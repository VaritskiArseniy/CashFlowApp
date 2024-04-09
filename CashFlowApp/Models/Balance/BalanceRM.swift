import RealmSwift

class BalanceRM: Object {
    @Persisted var total: Int
    @Persisted var income: Int
    @Persisted var expenses: Int
    
    convenience init(total: Int, income: Int, expenses: Int) {
        self.init()
        self.total = total
        self.income = income
        self.expenses = expenses
    }
}

extension BalanceRM {
    var toModel: Balance {
        .init(total: total, income: income, expenses: expenses)
    }
}
