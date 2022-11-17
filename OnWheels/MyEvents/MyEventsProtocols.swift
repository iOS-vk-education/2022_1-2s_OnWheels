//
//  MyEventsProtocols.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import Foundation

protocol MyEventsModuleInput {
	var moduleOutput: MyEventsModuleOutput? { get }
}

protocol MyEventsModuleOutput: class {
}

protocol MyEventsViewInput: class {
}

protocol MyEventsViewOutput: class {
}

protocol MyEventsInteractorInput: class {
}

protocol MyEventsInteractorOutput: class {
}

protocol MyEventsRouterInput: class {
}
