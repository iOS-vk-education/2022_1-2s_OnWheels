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

}

extension LogInPresenter: LogInModuleInput {
}

extension LogInPresenter: LogInViewOutput {

    func didTapLoginButton() {
        //логика входа
        router.openApp()
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
}
