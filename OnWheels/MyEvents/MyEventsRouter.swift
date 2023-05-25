//
//  MyEventsRouter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import UIKit

final class MyEventsRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension MyEventsRouter: MyEventsRouterInput {
    func jumpButtonPressed() {
        let oneEventContainer = OneEventContainer.assemble(with: .init(raceId: 4))
        self.viewController?.navigationController?.pushViewController(
            oneEventContainer.viewController,
            animated: true
        )
    }
}

