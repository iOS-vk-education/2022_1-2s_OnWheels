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
    private let locationDecoder: LocationDecoder
    
    init(raceManager: RacesNetworkManager, locationDecoder: LocationDecoder) {
        self.raceManager = raceManager
        self.locationDecoder = locationDecoder
    }
}

extension AddEventInteractor: AddEventInteractorInput {
    func addRace(with raceInfo: [String?]) {
        let raceInfoStrings = raceInfo.compactMap{ $0 }
        
        // TODO: сделать с помощью экстеншена Артема перевод времени из строки
        let raceDate = Duration(from: "2023-04-10T08:18:45.754Z", to: "2023-04-10T08:18:45.754Z")
        
        locationDecoder.getLocation(from: raceInfoStrings[3]) { location, error in
            if let error = error {
                print("Ошибка получения координат: \(error.localizedDescription)")
            } else if let location = location {
                let addRaceModel = AddRace(name: raceInfoStrings[0],
                                           location: location,
                                           date: raceDate,
                                           addRaceDescription: raceInfoStrings[4],
                                           images: [""],
                                           tags: [""])
                self.raceManager.postRace(with: addRaceModel) { error in
                    if error == nil {
                        self.output?.addButtonWasTapped()
                    } else {
                        print(error)
                    }
                }
            }
        }
    }
}

