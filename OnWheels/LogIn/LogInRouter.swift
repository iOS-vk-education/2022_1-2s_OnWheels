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
}

extension LogInRouter: LogInRouterInput {

    func openRegScreen() {
        let registrationContainer = RegistrationContainer.assemble(with: RegistrationContext())

        viewController?.navigationController?.pushViewController(registrationContainer.viewController, animated: true)
    }

    func openApp() {
        //TODO: go to app
    }

}
