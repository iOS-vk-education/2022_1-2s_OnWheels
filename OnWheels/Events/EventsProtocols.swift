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
    func setData(raceData: RaceList)
}

protocol EventsViewOutput: AnyObject {
    func rowDidSelect(at index: Int)
    func didLoadRaces()
}

protocol EventsInteractorInput: AnyObject {
    func loadRaces()
}

protocol EventsInteractorOutput: AnyObject {
    func setRaces(races: RaceList)
}

protocol EventsRouterInput: AnyObject {
    func selectedRowTapped(at index: Int)
}
