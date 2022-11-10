//
//  EventsProtocols.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import Foundation

protocol EventsModuleInput {
	var moduleOutput: EventsModuleOutput? { get }
}

protocol EventsModuleOutput: class {
}

protocol EventsViewInput: class {
}

protocol EventsViewOutput: class {
}

protocol EventsInteractorInput: class {
}

protocol EventsInteractorOutput: class {
}

protocol EventsRouterInput: class {
}
