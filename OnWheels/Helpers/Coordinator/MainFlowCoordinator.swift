//
//  MainFlowCoordinator.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//

import UIKit

final class MainFlowCoordinator: CoordinatorProtocol {
    internal var window: UIWindow
    private let tabBar: CustomTabBar
    init (window: UIWindow) {
        self.window = window
        self.tabBar = CustomTabBar(window: window)
    }

    func start() {
        start(nil)
    }

    func start(_ deepLink: DeeplinkData?) {
        window.rootViewController = tabBar
        if let deepLink = deepLink, case DeeplinkData.race(let raceID) = deepLink {
            guard let navController = self.navigationControllers[.events] else {
                print("No navController for events, can't deeplink")
                return
            }
            let oneEvent = OneEventContainer.assemble(with: .init(moduleOutput: nil, window: window, raceId: raceID))
            navController.pushViewController(oneEvent.viewController, animated: true)
        } else {
            print("no deeplink found")
        }
        window.makeKeyAndVisible()
    }
}

