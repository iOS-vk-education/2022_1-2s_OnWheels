//
//  EventsContainer.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//  
//

import UIKit

final class EventsContainer {
    let input: EventsModuleInput
	let viewController: UIViewController
	private(set) weak var router: EventsRouterInput!

	class func assemble(with context: EventsContext) -> EventsContainer {
        let router = EventsRouter()
        let interactor = EventsInteractor()
        let presenter = EventsPresenter(router: router, interactor: interactor)
		let viewController = EventsViewController(output: presenter)

		presenter.view = viewController
        router.window = context.window
        router.viewController = viewController
		presenter.moduleOutput = context.moduleOutput
        presenter.view = viewController

		interactor.output = presenter

        return EventsContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: EventsModuleInput, router: EventsRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct EventsContext {
	weak var moduleOutput: EventsModuleOutput?
    let window: UIWindow
}
