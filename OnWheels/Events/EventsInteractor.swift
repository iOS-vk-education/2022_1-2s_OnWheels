//
//  EventsInteractor.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//  
//

import Foundation

final class EventsInteractor {
	weak var output: EventsInteractorOutput?
    private let raceManager: RacesNetworkManager
    
    init(raceManager: RacesNetworkManager) {
        self.raceManager = raceManager
    }
}

extension EventsInteractor: EventsInteractorInput {
    func loadRaces(){
        raceManager.getAllRaces { races, error in
            if let error = error {
                print(error)
            }
            if let races = races {
                print(races)
            }
        }
    }
}
