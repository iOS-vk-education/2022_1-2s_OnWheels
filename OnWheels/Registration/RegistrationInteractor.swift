//
//  RegistrationInteractor.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import Foundation

final class RegistrationInteractor {
    weak var output: RegistrationInteractorOutput?
    private let userManager: UserNetworkManager
    
    init(userManager: UserNetworkManager) {
        self.userManager = userManager
    }
}

extension RegistrationInteractor: RegistrationInteractorInput {
    func registerUser(with info: [String?]) {
        let registerInfo = info.compactMap{$0}
        var sex: Int = 0
        if registerInfo[3] == "муж" {
            sex = 0
        } else {
            sex = 1
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm:ss Z"
        guard let date = dateFormatter.date(from: registerInfo[2]) else { return }
        userManager.register(surname: registerInfo[1],
                             name: registerInfo[0],
                             email: registerInfo[5],
                             password: registerInfo[6],
                             city: registerInfo[4],
                             birthday: date,
                             sex: sex) { status in
            switch status {
            case .authorized:
                break
            case .nonAuthorized(error: let error):
                break
            }
        }
        
    }
}
