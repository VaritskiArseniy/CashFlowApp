protocol UseCasesAssemblyProtocol {
    var transactionUseCase: TransactionUseCaseProtocol { get }
}


class UseCasesAssembly: UseCasesAssemblyProtocol {
    
    var realmManager: RealmManagerProtocol = RealmManager()
    
    lazy var transactionUseCase: TransactionUseCaseProtocol = TransactionUseCase(realmManager: realmManager)
}
