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
    func setUser(to newUser: CurrentUser)
}

protocol ProfileViewOutput: AnyObject {
    func logout()
    func deleteAccount()
    func loadInfo()
}

protocol ProfileInteractorInput: AnyObject {
    func loadUserInfo()
}

protocol ProfileInteractorOutput: AnyObject {
    func setUserData(user: CurrentUser)
}

protocol ProfileRouterInput: AnyObject {
    func logout()
    func deleteAccount()
}
