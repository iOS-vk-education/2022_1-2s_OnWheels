//
//  RegistrationRouter.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import UIKit

final class RegistrationRouter {
    var viewController: UIViewController?
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
}

extension RegistrationRouter: RegistrationRouterInput {
    func openApp() {
        guard let window = window else {
            return
        }
        // TODO deeplink even after registration
        let coordinator = AppCoordinator(window: window, instructor: .main(nil))
        coordinator.start()
    }
    
    func backButtonTapped(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
}
