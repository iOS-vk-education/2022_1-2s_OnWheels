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
    func didTapRegButton(regInfo: [String?]) {
        interactor.registerUser(with: regInfo)
    }
    
    
    func backButtonAction(){
        router.backButtonTapped()
    }
}

extension RegistrationPresenter: RegistrationInteractorOutput {
    func authorized() {
        router.openApp()
    }
    
    func notAuthorized(withReason reason: String) {
        print("\(reason)")
    }
}
