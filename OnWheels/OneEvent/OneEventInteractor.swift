//
//  OneEventInteractor.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import Foundation

final class OneEventInteractor {
	weak var output: OneEventInteractorOutput?
    
    private let raceManager: RacesNetworkManager
    private let raceId: Int
    
    init(raceManager: RacesNetworkManager, raceId: Int) {
        self.raceManager = raceManager
        self.raceId = raceId
    }
    
}

extension OneEventInteractor: OneEventInteractorInput {
    func loadRaceInfo() {
        self.raceManager.getRace(with: raceId) { race, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let race = race {
//                    print(race)
                    self.output?.setRace(races: race)
                }
            }
        }
    }
}
