//
//  EnterPresenter.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import Foundation

final class EnterPresenter {
	weak var view: EnterViewInput?
    weak var moduleOutput: EnterModuleOutput?
    
	private let router: EnterRouterInput
	private let interactor: EnterInteractorInput
    
    init(router: EnterRouterInput, interactor: EnterInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension EnterPresenter: EnterModuleInput {
}

extension EnterPresenter: EnterViewOutput {
    func showNextScreen(){
        router.timerFinished()
    }
}

extension EnterPresenter: EnterInteractorOutput {
}
