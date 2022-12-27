//
//  LogInContainer.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit

final class LogInContainer {
    let input: LogInModuleInput
    let viewController: UIViewController
    private(set) weak var router: LogInRouterInput!
    
    class func assemble(with context: LogInContext) -> LogInContainer {
        let router = LogInRouter()
        let networkRouter = Router<UserEndPoint>()
        let authManager = UserNetworkManagerImpl(router: networkRouter)
        let interactor = LogInInteractor(userManager: authManager)
        let presenter = LogInPresenter(router: router, interactor: interactor)
        let viewController = LogInViewController(output: presenter)
        
        router.viewController = viewController
        router.window = context.window
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return LogInContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: LogInModuleInput, router: LogInRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct LogInContext {
    weak var moduleOutput: LogInModuleOutput?
    let window: UIWindow
}
