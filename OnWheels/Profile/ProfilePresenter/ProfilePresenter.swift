//
//  ProfilePresenter.swift
//  OnWheels
//
//  Created by Артём on 07.04.2023.
//

import Foundation

struct ProfileUserInfo {
    let firstname: String
    let surname: String
    let city: String
    let email: String
    let birthday: String
    let sex: String
    
    var fullName: String {
        return firstname + " " + surname
    }
}

protocol ProfilePresenter {
    func update()
    func setViewController(viewController: ProfileView)

    // MARK: - связка с сервисом, функции для вьюшки
    func logout()
    func deleteAccount()
}
