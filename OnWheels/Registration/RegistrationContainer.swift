//
//  RegistrationContainer.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import UIKit

final class RegistrationContainer {
    let input: RegistrationModuleInput
    let viewController: UIViewController
    private(set) weak var router: RegistrationRouterInput!
    
    class func assemble(with context: RegistrationContext) -> RegistrationContainer {
        let router = RegistrationRouter()
        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter(router: router, interactor: interactor)
        let viewController = RegistrationViewController(output: presenter)
        
        router.viewController = viewController
        router.window = context.window
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return RegistrationContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: RegistrationModuleInput, router: RegistrationRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct RegistrationContext {
    weak var moduleOutput: RegistrationModuleOutput?
    let window: UIWindow
}
