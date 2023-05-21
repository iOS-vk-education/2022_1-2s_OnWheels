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
        let networkRaceRouter = Router<RaceEndPoint>()
        let raceManager = RacesNetworkManagerImpl(router: networkRaceRouter)
        let locationDecoder = LocationDecoder()
        let networkImageRouter = Router<ImageEndPoint>()
        let imageManager = ImageManagerImpl(router: networkImageRouter)
        let interactor = AddEventInteractor(raceManager: raceManager, locationDecoder: locationDecoder, imageManager: imageManager)
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
