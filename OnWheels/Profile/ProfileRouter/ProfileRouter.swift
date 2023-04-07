//
//  ProfileRouterProtocol.swift
//  OnWheels
//
//  Created by Артём on 07.04.2023.
//

import UIKit

protocol ProfileRouter {
    init(window: UIWindow, navigationController: UINavigationController)
    func start()
    func setViewController(viewController: UIViewController)
}
