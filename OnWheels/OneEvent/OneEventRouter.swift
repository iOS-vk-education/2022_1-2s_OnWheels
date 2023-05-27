//
//  OneEventRouter.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import UIKit

final class OneEventRouter {
//    var window: UIWindow?
    var viewController: UIViewController?
}

extension OneEventRouter: OneEventRouterInput {
    func backButtonPressed(){
        self.viewController?.navigationController?.popViewController(animated: true)
    }
}
