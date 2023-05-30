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
    var deepLink: DeeplinkData?
}

extension EnterRouter: EnterRouterInput {
    func timerFinished(){
        // TODO check if cookies present
        // TODO somewhere here souhld be deep linker
        let cookies = HTTPCookieStorage.shared.cookies?.first(where: { cookie in
            cookie.name == ".AspNetCore.Session"
        })
        guard let window = window else { return }

        if let _ = cookies {
            appCoordinator = AppCoordinator(window: window, instructor: .main(deepLink))
        } else {
            appCoordinator = AppCoordinator(window: window, instructor: .authorization)
        }
        appCoordinator?.start()
    }
}
