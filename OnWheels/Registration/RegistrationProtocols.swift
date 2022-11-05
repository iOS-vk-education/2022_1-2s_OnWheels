//
//  RegistrationProtocols.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import Foundation

protocol RegistrationModuleInput {
	var moduleOutput: RegistrationModuleOutput? { get }
}

protocol RegistrationModuleOutput: AnyObject {
}

protocol RegistrationViewInput: AnyObject {
}

protocol RegistrationViewOutput: AnyObject {
}

protocol RegistrationInteractorInput: AnyObject {
}

protocol RegistrationInteractorOutput: AnyObject {
}

protocol RegistrationRouterInput: AnyObject {
}
