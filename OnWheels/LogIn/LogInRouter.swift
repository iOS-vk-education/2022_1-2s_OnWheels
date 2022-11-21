//
//  LogInRouter.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit

final class LogInRouter {
    var viewController: UIViewController?
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
}

extension LogInRouter: LogInRouterInput {

    func openRegScreen() {
        guard let window = window else {
            return
        }
        let registrationContext = RegistrationContext(window: window)
        let registrationContainer = RegistrationContainer.assemble(with: registrationContext)
        viewController?.navigationController?.pushViewController(registrationContainer.viewController, animated: true)
    }

    func openApp() {
        guard let window = window else {
            return
        }
        let coordinator = AppCoordinator(window: window, instructor: .main)
        coordinator.start()
    }

}
