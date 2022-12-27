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
    
    func getIndexesOfEmptyFields(registerInfo: [String?]) -> [Int] {
        var result = [Int]()
        for (index, info) in registerInfo.enumerated() {
            guard let info = info else {
                result.append(index)
                continue
            }
            if info.isEmpty {
                result.append(index)
            }
        }
        return result
    }
    
    func checkPassword(registerInfo: [String?]) -> Bool {
        if registerInfo[6] == registerInfo[7] {
            return true
        } else {
            return false
        }
    }
}

extension RegistrationPresenter: RegistrationModuleInput {
}

extension RegistrationPresenter: RegistrationViewOutput {
    func didTapRegButton(regInfo: [String?]) {
        let emptyFieldsIndexes = getIndexesOfEmptyFields(registerInfo: regInfo)
        if emptyFieldsIndexes.isEmpty && checkPassword(registerInfo: regInfo) {
            interactor.registerUser(with: regInfo)
        } else if !emptyFieldsIndexes.isEmpty{
            view?.showEmptyFields(withIndexes: emptyFieldsIndexes)
        } else if !checkPassword(registerInfo: regInfo){
            view?.showCheckedPassword()
        }
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
