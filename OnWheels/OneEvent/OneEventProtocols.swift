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
    func showError(error: String)
}

protocol OneEventViewOutput: AnyObject {
    func backButtonTapped()
    func loadInfo()
    func postMember()
    func removeMember()
    func raceID() -> Int
}

protocol OneEventInteractorInput: AnyObject {
    func loadRaceInfo()
    func addMember()
    func deleteMember()
    func getRaceId() -> Int
}

protocol OneEventInteractorOutput: AnyObject {
    func setRace(races: OneEvent)
    func setMember()
    func deleteMember()
    func showError(error: String) 
}

protocol OneEventRouterInput: AnyObject {
    func backButtonPressed()
}
