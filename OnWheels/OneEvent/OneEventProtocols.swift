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

protocol OneEventModuleOutput: class {
}

protocol OneEventViewInput: class {
}

protocol OneEventViewOutput: class {
}

protocol OneEventInteractorInput: class {
}

protocol OneEventInteractorOutput: class {
}

protocol OneEventRouterInput: class {
}
