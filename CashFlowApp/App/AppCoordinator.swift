import UIKit

final class AppCoordinator {
    private let assembly: AppAssembly
    private var navigationViewController: UINavigationController?
    private var homeInput: HomeInput?
    
    private var tabBarControllers: [UIViewController] {
        let homeAssembly = assembly.makeHome(output: self)
        let homeVC = homeAssembly.0
        homeInput = homeAssembly.1
        let statisticsVC = assembly.makeStatistics(output: self)
        return [homeVC, statisticsVC]
    }
    
    init(assembly: AppAssembly) {
        self.assembly = assembly
    }
    
    func start(window: UIWindow) {
        let isLaunchBefore = UserDefaults.standard.bool(forKey: "isLaunchBefore")
        let mainVC = assembly.makeMain(output: self, controllers: tabBarControllers)
        let onboardingVC = assembly.makeOnboarding(output: self)
        navigationViewController = UINavigationController(rootViewController: isLaunchBefore ? mainVC : onboardingVC)
        window.rootViewController = navigationViewController
        window.makeKeyAndVisible()
    }
}

// MARK: - OnboardingOutput

extension AppCoordinator: OnboardingOutput {
    func showBasePreferences() {
        let vc = assembly.makeBasePreferences(output: self)
        navigationViewController?.pushViewController(vc, animated: true)
    }
}

// MARK: - BasePreferencesOutput

extension AppCoordinator: BasePreferencesOutput {
    func showMain() {
        let vc = assembly.makeMain(output: self, controllers: tabBarControllers)
        navigationViewController?.pushViewController(vc, animated: true)
    }
}

// MARK: - HomeOutput

extension AppCoordinator: HomeOutput {
    func showTransactionHistory() {
        let vc = assembly.makeTransactionHistory(output: self)
        navigationViewController?.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: TransactionHistoryOutput {
    func close() {
        navigationViewController?.popViewController(animated: true)
    }
}

// MARK: - MainTabbarOutput

extension AppCoordinator: MainTabbarOutput {
    func showAddTransaction() {
        let vc = assembly.makeAddTransaction(output: self)
        navigationViewController?.pushViewController(vc, animated: true)
    }
}

// MARK: - AddTransactionOutput

extension AppCoordinator: AddTransactionOutput {
    func closeAfterAddTransaction() {
        navigationViewController?.popViewController(animated: true)
        homeInput?.addedNewTransaction()
    }
}

extension AppCoordinator: StatisticsOutput {
    
}
