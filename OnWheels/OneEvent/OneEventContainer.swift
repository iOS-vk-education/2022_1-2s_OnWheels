//
//  OneEventContainer.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import UIKit

final class OneEventContainer {
    let input: OneEventModuleInput
	let viewController: UIViewController
	private(set) weak var router: OneEventRouterInput!

	static func assemble(with context: OneEventContext) -> OneEventContainer {
        let router = OneEventRouter()
        let networkRouter = Router<RaceEndPoint>()
        let raceManager = RacesNetworkManagerImpl(router: networkRouter)
        let raceId = context.raceId
        let interactor = OneEventInteractor(raceManager: raceManager, raceId: raceId)
        let presenter = OneEventPresenter(router: router, interactor: interactor)
		let viewController = OneEventViewController(output: presenter)

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput
//        router.window = context.window
        router.viewController = viewController
		interactor.output = presenter
        

        return OneEventContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: OneEventModuleInput, router: OneEventRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct OneEventContext {
	weak var moduleOutput: OneEventModuleOutput?
//    let window: UIWindow
    let raceId: Int
}
