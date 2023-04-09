//
//  MyEventsInteractor.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//

import Foundation

final class AddEventInteractor {
	weak var output: AddEventInteractorOutput?
    private let raceManager: RacesNetworkManager
    
    init(raceManager: RacesNetworkManager) {
        self.raceManager = raceManager
    }
}

extension AddEventInteractor: AddEventInteractorInput {
    func addRace(with raceInfo: [String?]) {
        
    }
}
