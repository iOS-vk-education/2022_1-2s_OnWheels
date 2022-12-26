//
//  EventsProtocols.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//  
//

import Foundation

protocol EventsModuleInput {
	var moduleOutput: EventsModuleOutput? { get }
}

protocol EventsModuleOutput: AnyObject {
}

protocol EventsViewInput: AnyObject {
}

protocol EventsViewOutput: AnyObject {
    func rowDidSelect()
    func didLoadRaces()
}

protocol EventsInteractorInput: AnyObject {
    func loadRaces()
}

protocol EventsInteractorOutput: AnyObject {
}

protocol EventsRouterInput: AnyObject {
    func selectedRowTapped()
}
