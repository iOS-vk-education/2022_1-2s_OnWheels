//
//  ProfilePresenterProtocol.swift
//  OnWheels
//
//  Created by Артём on 07.04.2023.
//

import Foundation

protocol ProfilePresenter {
    func update()
    func setViewController(viewController: ProfileView)

    // MARK: - связка с сервисом, функции для вьюшки
    func logout()
    func deleteAccount()
}
