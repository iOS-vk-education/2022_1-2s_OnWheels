//
//  MyEventsPresenter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import Foundation

final class MyEventsPresenter {
    weak var view: MyEventsViewInput?
    weak var moduleOutput: MyEventsModuleOutput?
    
    private let router: MyEventsRouterInput
    private let interactor: MyEventsInteractorInput
    
    init(router: MyEventsRouterInput, interactor: MyEventsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MyEventsPresenter: MyEventsModuleInput {
}

extension MyEventsPresenter: MyEventsViewOutput {
    func jumpButtonTapped(){
        router.jumpButtonPressed()
    }
    }
    


extension MyEventsPresenter: MyEventsInteractorOutput {
}

