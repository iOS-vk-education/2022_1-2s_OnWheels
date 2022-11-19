//
//  LogInProtocols.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import Foundation

protocol LogInModuleInput {
	var moduleOutput: LogInModuleOutput? { get }
}

protocol LogInModuleOutput: AnyObject {
}

protocol LogInViewInput: AnyObject {
}

protocol LogInViewOutput: AnyObject {
    func didTapLoginButton()
    func didTapRegButton()
    func didTapForgotPassButton()
    func didTapNoAccountButton()
}

protocol LogInInteractorInput: AnyObject {
}

protocol LogInInteractorOutput: AnyObject {
}

protocol LogInRouterInput: AnyObject {
    func openRegScreen()
    func openApp()
}
