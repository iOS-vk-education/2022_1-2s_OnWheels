//
//  MyEventsRouter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import UIKit

final class MyEventsRouter {
    var window: UIWindow?
    var viewController: UIViewController?
}

extension MyEventsRouter: MyEventsRouterInput {
    func jumpButtonPressed(){
        self.viewController?.navigationController?.pushViewController( OneEventViewController, animated: true)
    }
}

