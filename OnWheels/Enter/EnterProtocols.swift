//
//  EnterProtocols.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import Foundation

protocol EnterModuleInput {
    var moduleOutput: EnterModuleOutput? { get }
}

protocol EnterModuleOutput: AnyObject {
}

protocol EnterViewInput: AnyObject {
}

protocol EnterViewOutput: AnyObject {
    func showNextScreen()
}

protocol EnterInteractorInput: AnyObject {
}

protocol EnterInteractorOutput: AnyObject {
}

protocol EnterRouterInput: AnyObject {
    func timerFinished()
}
