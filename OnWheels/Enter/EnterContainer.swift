//
//  EnterContainer.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import UIKit

final class EnterContainer {
    let input: EnterModuleInput
    let viewController: UIViewController
    private(set) weak var router: EnterRouterInput!
    
    static func assemble(with context: EnterContext) -> EnterContainer {
        let router = EnterRouter()
        router.deepLink = context.deeplink
        let interactor = EnterInteractor()
        let presenter = EnterPresenter(router: router, interactor: interactor)
        let viewController = EnterViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        router.viewController = viewController
        interactor.output = presenter
        router.window = context.window
        
        
        return EnterContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: EnterModuleInput, router: EnterRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

enum DeeplinkData {
    case race(Int)
}

struct EnterContext {
    weak var moduleOutput: EnterModuleOutput?
    let window: UIWindow
    var deeplink: DeeplinkData?
}
