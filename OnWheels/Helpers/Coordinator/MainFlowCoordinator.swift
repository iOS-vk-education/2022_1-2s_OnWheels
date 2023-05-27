//
//  MainFlowCoordinator.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//

import UIKit

final class MainFlowCoordinator: CoordinatorProtocol{
    internal var window: UIWindow
    private let tabBar: CustomTabBar
    init (window: UIWindow) {
        self.window = window
        self.tabBar = CustomTabBar(window: window)
    }
    
    func start() {
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
    }
}

