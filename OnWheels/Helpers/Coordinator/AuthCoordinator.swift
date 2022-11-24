//
//  AuthCoordinator.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//

import UIKit

final class AuthCoordinator: CoordinatorProtocol {
    internal var window: UIWindow
    private lazy var navigationControllers = AuthCoordinator.makeNavigationControllers()
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        setupLogin()
        
        let navControllers = NavControllerType.allCases.compactMap {
            self.navigationControllers[$0]
        }

        window.rootViewController = navControllers[0]
        window.makeKeyAndVisible()
    }
    
    enum LaunchInstructor {
        case login, registration
    }
}

extension AuthCoordinator {
    
    private func setupLogin() {
        guard let navController = navigationControllers[.auth] else {
            print("No navController")
            return
        }
        let LogInContext = LogInContext(window: window)
        let loginContainer = LogInContainer.assemble(with: LogInContext)
        navController.setViewControllers([loginContainer.viewController], animated: true)
    }
    
    fileprivate static func makeNavigationControllers() -> [NavControllerType: UINavigationController] {
        var result: [NavControllerType: UINavigationController] = [:]
        NavControllerType.allCases.forEach { navControllerKey in
            let navigationController = UINavigationController()
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            navigationController.navigationBar.scrollEdgeAppearance = navBarAppearance
            result[navControllerKey] = navigationController
        }
        return result
    }
}

fileprivate enum NavControllerType: Int, CaseIterable {
    case auth
}
