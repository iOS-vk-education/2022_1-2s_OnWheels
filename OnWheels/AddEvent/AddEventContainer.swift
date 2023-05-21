//
//  MyEventsContainer.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import UIKit

final class AddEventContainer {
    let input: AddEventModuleInput
    let viewController: UIViewController
    private(set) weak var router: AddEventRouterInput!
    
    class func assemble(with context: AddEventContext) -> AddEventContainer {
        let router = AddEventRouter()
        let networkRouter = Router<RaceEndPoint>()
        let raceManager = RacesNetworkManagerImpl(router: networkRouter)
        let locationDecoder = LocationDecoder()
        let interactor = AddEventInteractor(raceManager: raceManager, locationDecoder: locationDecoder)
        let presenter = AddEventPresenter(router: router, interactor: interactor)
        let viewController = AddEventViewController(output: presenter)
        
        router.viewController = viewController
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return AddEventContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: AddEventModuleInput, router: AddEventRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct AddEventContext {
    weak var moduleOutput: AddEventModuleOutput?
}
