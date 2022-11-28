//
//  EventsRouter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//  
//

import UIKit

final class EventsRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension EventsRouter: EventsRouterInput {
    func selectedRowTapped(){
        guard let window = window else {
            return
        }
        let oneEventContext = OneEventContext(window: window)
        let oneEventContainer = OneEventContainer.assemble(with: oneEventContext)
        viewController?.navigationController?.pushViewController(oneEventContainer.viewController, animated: true)
    }
}
