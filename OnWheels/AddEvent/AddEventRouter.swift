//
//  MyEventsRouter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import UIKit

final class AddEventRouter {
}

extension AddEventRouter: AddEventRouterInput {
    func didTapCloseButton() {
        print("Здесь будет закрываться вью контроллер")
    }
    
    func didTapAddButton() {
        
    }
}
