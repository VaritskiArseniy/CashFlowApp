import Foundation

protocol OnboardingViewModelInterface {
    func showBasePreferences()
}

final class OnboardingViewModel {
    private weak var output: OnboardingOutput?
    
    init(output: OnboardingOutput?) {
        self.output = output
    }
}

extension OnboardingViewModel: OnboardingViewModelInterface {
    func showBasePreferences() {
        output?.showBasePreferences()
    }
}
