import UIKit

class AppAssembly {
    private let useCasesAssembly: UseCasesAssemblyProtocol

    init(useCasesAssembly: UseCasesAssemblyProtocol = UseCasesAssembly()) {
        self.useCasesAssembly = useCasesAssembly
    }
    
    func makeOnboarding(output: OnboardingOutput) -> UIViewController {
        let viewModel = OnboardingViewModel(output: output)
        let controller = OnboardingViewController(viewModel: viewModel)
        return controller
    }
    
    func makeBasePreferences(output: BasePreferencesOutput) -> UIViewController {
        let viewModel = BasePreferencesViewModel(output: output, transactionUseCase: useCasesAssembly.transactionUseCase)
        let controller = BasePreferencesViewController(viewModel: viewModel)
        return controller
    }
    
    func makeMain(output: MainTabbarOutput, controllers: [UIViewController]) -> UIViewController {
        let viewModel = MainTabbarViewModel(output: output)
        let controller = MainTabbarViewController(controllers: controllers, viewModel: viewModel)
        return controller
    }    
    
    func makeHome(output: HomeOutput) -> (UIViewController, HomeViewModel) {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = .homeIc
        tabBarItem.selectedImage = .homeSelectedIc.withTintColor(.c3F8782)

        let viewModel = HomeViewModel(
            output: output,
            transactionUseCase: useCasesAssembly.transactionUseCase
        )

        let controller = HomeViewController(viewModel: viewModel)
        controller.tabBarItem = tabBarItem
        viewModel.view = controller
        return (controller, viewModel)
    }
    
    func makeStatistics(output: StatisticsOutput) -> UIViewController {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = .chartIc
        tabBarItem.selectedImage = .chartSelectedIc.withTintColor(.c3F8782)
        let viewModel = StatisticsViewModel(transactionUseCase: useCasesAssembly.transactionUseCase, output: output)
        let controller = StatisticsViewController(viewModel: viewModel)
        viewModel.view = controller
        controller.tabBarItem = tabBarItem
        return controller
    }
    
    func makeAddTransaction(output: AddTransactionOutput) -> UIViewController {
        let viewModel = AddTransactionViewModel(
            transactionUseCase: useCasesAssembly.transactionUseCase,
            output: output
        )
        let vc = AddTransactionViewController(viewModel: viewModel)
        viewModel.view = vc
        return vc
    }
    
    func makeTransactionHistory(output: TransactionHistoryOutput) -> UIViewController {
        let viewModel = TransactionHistoryViewModel(
            transactionUseCase: useCasesAssembly.transactionUseCase,
            output: output
        )
        let vc = TransactionHistoryViewController(viewModel: viewModel)
        return vc
    }
}
