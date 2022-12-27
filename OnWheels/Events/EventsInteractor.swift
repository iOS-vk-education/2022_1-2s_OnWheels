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
        raceManager.getListOfRaces { races, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let races = races {
                    self.output?.setRaces(races: races)
                }
            }
        }
    }
    
    func setLike(for raceId: Int){
        raceManager.postLike(with: raceId) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    print(raceId)
                    self.output?.setLike(raceId: raceId)
                }
            }
        }
    }
    
    func setView(for raceId: Int) {
        raceManager.postView(with: raceId) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    print(raceId)
                }
            }
        }
    }
}
