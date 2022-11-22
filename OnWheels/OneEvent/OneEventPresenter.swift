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
    func backButtonTapped(){
        router.backButtonPressed()
    }
}

extension OneEventPresenter: OneEventInteractorOutput {
}
