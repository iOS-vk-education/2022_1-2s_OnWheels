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
    func setData(raceData: OneRace)
}

protocol OneEventViewOutput: AnyObject {
    func backButtonTapped()
    func loadInfo()
}

protocol OneEventInteractorInput: AnyObject {
    func loadRaceInfo()
}

protocol OneEventInteractorOutput: AnyObject {
    func setRace(races: OneRace)
}

protocol OneEventRouterInput: AnyObject {
    func backButtonPressed()
}
