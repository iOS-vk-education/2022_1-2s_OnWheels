//
//  RegistrationPresenter.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import Foundation

final class RegistrationPresenter {
    weak var view: RegistrationViewInput?
    weak var moduleOutput: RegistrationModuleOutput?
    
    private let router: RegistrationRouterInput
    private let interactor: RegistrationInteractorInput
    
    init(router: RegistrationRouterInput, interactor: RegistrationInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension RegistrationPresenter: RegistrationModuleInput {
}

extension RegistrationPresenter: RegistrationViewOutput {
    func didTapRegButton() {
        router.openApp()
    }
    
    func backButtonAction(){
        router.backButtonTapped()
    }
}

extension RegistrationPresenter: RegistrationInteractorOutput {
}
