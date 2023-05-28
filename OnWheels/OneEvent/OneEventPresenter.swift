//
//  OneEventPresenter.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import Foundation

final class OneEventPresenter {
	weak var view: OneEventViewInput?
    weak var moduleOutput: OneEventModuleOutput?
    
	private let router: OneEventRouterInput
	private let interactor: OneEventInteractorInput
    
    init(router: OneEventRouterInput, interactor: OneEventInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension OneEventPresenter: OneEventModuleInput {
}

extension OneEventPresenter: OneEventViewOutput {
    func raceID() -> Int {
        interactor.getRaceId()
    }

    func backButtonTapped(){
        router.backButtonPressed()
    }
    
    func loadInfo(){
        interactor.loadRaceInfo()
    }
    
    func postMember() {
        interactor.addMember()
    }
    
    func removeMember() {
        interactor.deleteMember()
    }
}

extension OneEventPresenter: OneEventInteractorOutput {
    func showError(error: String) {
        view?.showError(error: error)
    }
    
    func setMember() {
        view?.addMember()
    }
    
    func deleteMember() {
        view?.deleteMember()
    }
    
    func setRace(races: OneEvent) {
        view?.setData(raceData: races)
    }
}
