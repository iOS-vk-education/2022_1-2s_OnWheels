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
    func didTapLoginButton()
    /// Обработка нажатия на кнопку регистрации
    func didTapRegButton()
    /// Обработка нажатия на кнопку забытия пароля
    func didTapForgotPassButton()
    /// Обработка нажатия на кнопку войти без УЗ
    func didTapNoAccountButton()
}

protocol LogInInteractorInput: AnyObject {
}

protocol LogInInteractorOutput: AnyObject {
}

protocol LogInRouterInput: AnyObject {
    /// Открывает экран с регистрацией
    func openRegScreen()
    /// Открывает приложение.
    func openApp()
}
