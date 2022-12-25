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
    /// Обработка нажатия на кнопку войти
    func didTapLoginButton(email: String, password: String)
    /// Обработка нажатия на кнопку регистрации
    func didTapRegButton()
    /// Обработка нажатия на кнопку забытия пароля
    func didTapForgotPassButton()
    /// Обработка нажатия на кнопку войти без УЗ
    func didTapNoAccountButton()
}

protocol LogInInteractorInput: AnyObject {
    func enterButtonPressed(email: String, password: String)
}

protocol LogInInteractorOutput: AnyObject {
    func authorized()
    func notAuthorized(withReason reason: String)
}

protocol LogInRouterInput: AnyObject {
    /// Открывает экран с регистрацией
    func openRegScreen()
    /// Открывает приложение.
    func openApp()
}
