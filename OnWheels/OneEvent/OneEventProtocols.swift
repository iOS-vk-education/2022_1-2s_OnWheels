//
//  OneEventProtocols.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import Foundation

protocol OneEventModuleInput {
	var moduleOutput: OneEventModuleOutput? { get }
}

protocol OneEventModuleOutput: AnyObject {
}

protocol OneEventViewInput: AnyObject {
}

protocol OneEventViewOutput: AnyObject {
}

protocol OneEventInteractorInput: AnyObject {
}

protocol OneEventInteractorOutput: AnyObject {
}

protocol OneEventRouterInput: AnyObject {
}
