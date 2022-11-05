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
}

protocol ProfileViewOutput: AnyObject {
    func openChangeProfileScreen()
}

protocol ProfileInteractorInput: AnyObject {
}

protocol ProfileInteractorOutput: AnyObject {
}

protocol ProfileRouterInput: AnyObject {
    func changeProfileInfoButtonTapped()
}
