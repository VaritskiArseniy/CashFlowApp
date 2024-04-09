import Foundation

protocol HomeOutput: AnyObject {
    func showTransactionHistory()
}

protocol HomeInput: AnyObject {
    func addedNewTransaction()
}
