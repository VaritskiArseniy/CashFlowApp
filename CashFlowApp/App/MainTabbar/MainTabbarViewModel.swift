import Foundation

protocol MainTabbarViewModelInterface {
    func showAddTransaction()
}

final class MainTabbarViewModel {
    private weak var output: MainTabbarOutput?
    
    init(output: MainTabbarOutput?) {
        self.output = output
    }
}

extension MainTabbarViewModel: MainTabbarViewModelInterface {
    func showAddTransaction() {
        output?.showAddTransaction()
    }
}
