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
    func didSetLike(for raceId: Int) {
        interactor.setLike(for: raceId)
    }
    
    func didSetDislike(for raceId: Int) {
        interactor.setDislike(for: raceId)
    }
    
    func rowDidSelect(at index: Int) {
        let race = interactor.getEvent(by: index)
        router.selectedRowTapped(at: race.id)
    }
    
    func didSetVeiw(at index: Int) {
        interactor.setView(for: index)
    }
    
    func didLoadRaces() {
        interactor.loadRaces()
    }
}

extension EventsPresenter: EventsInteractorOutput {
    func setDislike(for index: Int) {
        view?.setDislike(raceId: index)
    }
    
    func setLike(raceId: Int) {
        view?.setLike(raceId: raceId)
    }
    
    func setViews(raceId: Int) {
        view?.setView(raceId: raceId)
    }
    
    func setRaces(races: [RaceInfo]) {
        view?.update(withRaces: races)
    }
}
