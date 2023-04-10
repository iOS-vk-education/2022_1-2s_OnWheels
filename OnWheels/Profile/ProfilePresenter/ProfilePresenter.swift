//
//  ProfilePresenter.swift
//  OnWheels
//
//  Created by Артём on 07.04.2023.
//

import Foundation

struct ProfileUserInfo {
    let name: String
    let city: String
    let email: String
    let birthday: String
    let sex: String
}

protocol ProfilePresenter {
    func update()
    func setViewController(viewController: ProfileView)

    // MARK: - связка с сервисом, функции для вьюшки
    func logout()
    func deleteAccount()
}
