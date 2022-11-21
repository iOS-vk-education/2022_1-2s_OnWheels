//
//  EnterRouter.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import UIKit

final class EnterRouter {
    var viewController: UIViewController?
    var appCoordinator: AppCoordinator?
    var window: UIWindow?
}

extension EnterRouter: EnterRouterInput {
    func timerFinished(){
        guard let window = window else { return }
        appCoordinator = AppCoordinator(window: window, instructor: .authorization)
        appCoordinator?.start()
    }
}
