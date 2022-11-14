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
        let eventsContext = EventsContext(moduleOutput: nil)
        let eventsContainer = EventsContainer.assemble(with: eventsContext)
        eventsContainer.viewController.modalPresentationStyle = .fullScreen
        self.viewController?.present(eventsContainer.viewController, animated: false)
        appCoordinator = AppCoordinator(window: window, instructor: .main)
        appCoordinator?.start()
    }
}
