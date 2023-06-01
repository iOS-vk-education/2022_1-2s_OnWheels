//
//  AppCoordinator.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//

import UIKit


final class AppCoordinator: CoordinatorProtocol{
    internal var window: UIWindow
    private var instructor: LaunchInstructor
    init (window: UIWindow, instructor: LaunchInstructor) {
        self.window = window
        self.instructor = instructor
    }
    
    func start() {
        switch instructor {
        case .authorization:
            print("auth")
            performAuthorizationFlow()
        case .main(let deepLink):
            performMainFlow(deepLink)
        }
    }
    
    enum LaunchInstructor {
        case authorization, main(DeeplinkData?)
    }
}
extension AppCoordinator{
    private func performAuthorizationFlow(){
        let coordinator = AuthCoordinator(window: window)
        coordinator.start()
    }
    
    private func performMainFlow(_ deepLink: DeeplinkData?){
        let coordinator = MainFlowCoordinator(window: window)
        coordinator.start(deepLink)
    }
}
