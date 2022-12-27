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
    func didSetLike(for raceId: Int)
}

protocol EventsInteractorInput: AnyObject {
    func loadRaces()
    func setLike(for raceId: Int)
    func setView(for raceId: Int)
}

protocol EventsInteractorOutput: AnyObject {
    func setRaces(races: RaceList)
}

protocol EventsRouterInput: AnyObject {
    func selectedRowTapped(at index: Int)
}
