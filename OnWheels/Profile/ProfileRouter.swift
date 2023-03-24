//
//  ProfileRouter.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import UIKit

final class ProfileRouter {
    var window: UIWindow?
}

extension ProfileRouter: ProfileRouterInput {
    func deleteAccount() {
        print("delete account")
        // call to networking...
        guard let window = window else {
            return
        }
        let coordinator = AppCoordinator(window: window, instructor: .authorization)
        coordinator.start()
    }
    
    func logout() {
        print("logout")
        // call to networking...
        guard let window = window else {
            return
        }
        let coordinator = AppCoordinator(window: window, instructor: .authorization)
        coordinator.start()
    }
}
