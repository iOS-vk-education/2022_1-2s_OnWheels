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
    
    func rowDidSelect(at index: Int) {
        interactor.setView(for: index)
        router.selectedRowTapped(at: index)
    }
    
    
    func didLoadRaces() {
        interactor.loadRaces()
    }
}

extension EventsPresenter: EventsInteractorOutput {
    func setLike(raceId: Int) {
        view?.setLikeData(index: raceId)
        if userLiked.bool(forKey: "\(raceId)") {
            userLiked.set(false, forKey: "\(raceId)")
        } else {
            userLiked.set(true, forKey: "\(raceId)")
        }
        
    }
    
    func setViews(raceId: Int) {
        view?.setViewsData(index: raceId)
    }
    
    func setRaces(races: RaceList) {
        view?.setData(raceData: races)
    }
}
