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

protocol MyEventsModuleOutput: AnyObject {
}

protocol MyEventsViewInput: AnyObject {
}

protocol MyEventsViewOutput: AnyObject {
}

protocol MyEventsInteractorInput: AnyObject {
}

protocol MyEventsInteractorOutput: AnyObject {
}

protocol MyEventsRouterInput: AnyObject {
}
