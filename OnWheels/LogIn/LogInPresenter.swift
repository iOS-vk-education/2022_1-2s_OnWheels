//
//  LogInPresenter.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import Foundation

final class LogInPresenter {
    weak var view: LogInViewInput?
    weak var moduleOutput: LogInModuleOutput?
    
    private let router: LogInRouterInput
    private let interactor: LogInInteractorInput
    
    init(router: LogInRouterInput, interactor: LogInInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func getIndexesOfEmptyFields(email: String, password: String) -> [Int] {
        var result = [Int]()
        if email.isEmpty {
            result.append(0)
        }
        if password.isEmpty {
            result.append(1)
        }
        return result
    }
}

extension LogInPresenter: LogInModuleInput {
}

extension LogInPresenter: LogInViewOutput {
    
    func didTapLoginButton(email: String, password: String) {
        let emptyFields = getIndexesOfEmptyFields(email: email, password: password)
        if emptyFields.isEmpty {
            interactor.enterButtonPressed(email: email, password: password)
        } else {
            view?.showEmptyFields(withIndexes: emptyFields)
        }
    }
    
    func didTapForgotPassButton() {
        
    }
    
    func didTapNoAccountButton() {
        router.openApp()
    }
    
    func didTapRegButton() {
        router.openRegScreen()
    }
    
}
extension LogInPresenter: LogInInteractorOutput {
    func authorized() {
        router.openApp()
    }
    
    func notAuthorized(withReason reason: String) {
        DispatchQueue.main.sync {
            view?.showNonAuthorized(with: reason)
        }
    }
}
