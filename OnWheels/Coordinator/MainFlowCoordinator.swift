//
//  MainFlowCoordinator.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//

import Foundation
import UIKit

final class MainFlowCoordinator: CoordinatorProtocol{
    internal var window: UIWindow
    private lazy var tabBar: UITabBarController = UITabBarController()
    private lazy var navigationControllers = MainFlowCoordinator.makeNavigationControllers()
    init (window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupEvents()
        //        setupMyEvents()
        setupProfile()
        let navigationControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }
        tabBar.setViewControllers(navigationControllers, animated: true)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}

extension MainFlowCoordinator{
    private func setupEvents() {
        guard let navController = navigationControllers[.events] else {
            fatalError("No navController")
        }
        let eventsContext = EventsContext(moduleOutput: nil)
        let eventsContainer = EventsContainer.assemble(with: eventsContext)
        navController.setViewControllers([eventsContainer.viewController], animated: true)
    }
    //    private func setupMyEvents() {
    //        guard let navController = navigationControllers[.diet] else {
    //            fatalError("No navController")
    //        }
    //        let myEventsContext = MyEventsContext(moduleOutput: nil)
    //        let myEventsContainer = myEventsContainer.assemble(with: myEventsContext)
    //        navController.setViewControllers([myEventsContainer.viewController], animated: true)
    //    }
    
    private func setupProfile() {
        guard let navController = navigationControllers[.profile] else {
            fatalError("No navController")
        }
        let profileContext = ProfileContext(moduleOutput: nil)
        let profileContainer = ProfileContainer.assemble(with: profileContext)
        navController.setViewControllers([profileContainer.viewController], animated: true)
    }
    
    fileprivate static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let tabBarItem = UITabBarItem(title: navControllerKey.title,
                                          image: navControllerKey.image?.withRenderingMode(UIImage.RenderingMode.automatic),
                                          tag: navControllerKey.rawValue)
            navigationController.tabBarItem = tabBarItem
            result[navControllerKey] = navigationController
            UITabBar.appearance().backgroundColor = .white
            UITabBar.appearance().unselectedItemTintColor = .mainBlueColor
            UITabBar.appearance().tintColor = .mainOrangeColor
            
            navigationController.isNavigationBarHidden = true
        }
        return result
    }
}


fileprivate enum NavControllerType: Int, CaseIterable {
    case events, myEvents, profile
    
    var title: String {
        switch self {
        case .events:
            return "Мероприятия"
        case .myEvents:
            return "Мои мероприятия"
        case .profile:
            return "Профиль"
            
        }
    }
    
    var image: UIImage? {
        switch self {
        case .events:
            return UIImage(named: "Events")
        case .myEvents:
            return UIImage(named: "MyEvents")
        case .profile:
            return UIImage(named: "Profile")
        }
    }
}
