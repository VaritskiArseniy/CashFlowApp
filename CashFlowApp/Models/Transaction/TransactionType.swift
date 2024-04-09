import UIKit

enum TransactionType: String {
    case income
    case expenses
    
    var color: UIColor {
        switch self {
        case .income:
                .c25A969

        case .expenses:
                .cF95B51
        }
    }
    
    var symbol: String {
        switch self {
        case .income:
            "+"

        case .expenses:
            "-"
        }
    }
}
