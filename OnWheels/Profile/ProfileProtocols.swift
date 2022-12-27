//
//  ProfileProtocols.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import Foundation

protocol ProfileModuleInput {
    var moduleOutput: ProfileModuleOutput? { get }
}

protocol ProfileModuleOutput: AnyObject {
}

protocol ProfileViewInput: AnyObject {
    func getData(userData: CurrentUser)
}

protocol ProfileViewOutput: AnyObject {
    func openChangeProfileScreen()
    func logoutButtonTapped()
    func deleteAccountButtonTapped()
    func loadInfo()
}

protocol ProfileInteractorInput: AnyObject {
    func loadUserInfo()
}

protocol ProfileInteractorOutput: AnyObject {
    func setUserData(user: CurrentUser)
}

protocol ProfileRouterInput: AnyObject {
    func changeProfileInfoButtonTapped()
    func logoutButtonPressed()
    func deleteAccountButtonPressed()
}
