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
    func setData(raceData: OneEvent)
    func addMember()
    func deleteMember()
}

protocol OneEventViewOutput: AnyObject {
    func backButtonTapped()
    func loadInfo()
}

protocol OneEventInteractorInput: AnyObject {
    func loadRaceInfo()
    func addMember()
    func deleteMember()
}

protocol OneEventInteractorOutput: AnyObject {
    func setRace(races: OneEvent)
    func setMember()
    func deleteMember()
}

protocol OneEventRouterInput: AnyObject {
    func backButtonPressed()
}
