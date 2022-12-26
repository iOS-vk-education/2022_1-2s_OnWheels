//
//  EventsPresenter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//  
//

import Foundation

final class EventsPresenter {
	weak var view: EventsViewInput?
    weak var moduleOutput: EventsModuleOutput?

	private let router: EventsRouterInput
	private let interactor: EventsInteractorInput

    init(router: EventsRouterInput, interactor: EventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EventsPresenter: EventsModuleInput {
}

extension EventsPresenter: EventsViewOutput {
    func rowDidSelect(){
        router.selectedRowTapped()
    }
    
    func didLoadRaces() {
        interactor.loadRaces()
    }
}

extension EventsPresenter: EventsInteractorOutput {
}
