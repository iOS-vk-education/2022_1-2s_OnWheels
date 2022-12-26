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
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert([.withFractionalSeconds,
                                        .withInternetDateTime])
        let dateStr: [String] = registerInfo[2].components(separatedBy: ".")
        guard let date = formatter.date(from: "\(dateStr[2])-\(dateStr[1])-\(dateStr[0])T03:30:00.000Z") else {
            return
        }
        let string = formatter.string(from: date)
        self.userManager.register(surname: registerInfo[1],
                                  name: registerInfo[0],
                                  email: registerInfo[5],
                                  password: registerInfo[6],
                                  city: registerInfo[4],
                                  birthday: string,
                                  sex: sex) { status in
            switch status {
            case .authorized(let accsessToken):
                self.output?.authorized()
            case .nonAuthorized(let error):
                self.output?.notAuthorized(withReason: error)
            }
        }
    }
}
