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

protocol ProfileModuleOutput: class {
}

protocol ProfileViewInput: class {
}

protocol ProfileViewOutput: class {
}

protocol ProfileInteractorInput: class {
}

protocol ProfileInteractorOutput: class {
}

protocol ProfileRouterInput: class {
}
