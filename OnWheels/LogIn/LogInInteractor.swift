//
//  LogInInteractor.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import Foundation

final class LogInInteractor {
    weak var output: LogInInteractorOutput?
    private let userManager: UserNetworkManager
    
    init(userManager: UserNetworkManager) {
        self.userManager = userManager
    }
}

extension LogInInteractor: LogInInteractorInput {
    func enterButtonPressed(email: String, password: String){
        userManager.login(email: email, password: password) { status in
            switch status {
            case .authorized:
                self.output?.authorized()
            case .nonAuthorized(error: let error):
                self.output?.notAuthorized(withReason: error)
            }
        }
    }
}
