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
            guard let navControllers = tabBar.viewControllers, navControllers.count != 0 else {
                print("No navControllers, can't deeplink")
                return
            }
            let oneEvent = OneEventContainer.assemble(with: .init(moduleOutput: nil, raceId: raceID))
            (navControllers[0] as? UINavigationController)?.pushViewController(oneEvent.viewController, animated: true)
        } else {
            print("no deeplink found")
        }
        window.makeKeyAndVisible()
    }
}

