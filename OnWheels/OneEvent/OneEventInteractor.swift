//
//  OneEventInteractor.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import Foundation
import CoreLocation

final class OneEventInteractor {
	weak var output: OneEventInteractorOutput?
    
    private let raceManager: RacesNetworkManager
    private let userInteractionsManager: UserInteractionNetworkManager
    private let raceId: Int
    
    init(raceManager: RacesNetworkManager, userInteraction: UserInteractionNetworkManager, raceId: Int) {
        self.raceManager = raceManager
        self.userInteractionsManager = userInteraction
        self.raceId = raceId
    }
    
    
    private func formatDate(dateFrom: String, dateTo: String) -> String {
        var fromDateString = ""
        var toDateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.eventCellApiDateFormat
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let dateFrom = inputFormatter.date(from: dateFrom) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            fromDateString = outputFormatter.string(from: dateFrom)
        } else {
            fromDateString = "Error"
        }
        
        if let dateTo = inputFormatter.date(from: dateTo) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "en_US_POSIX")
            toDateString = outputFormatter.string(from: dateTo)
        }
        
        return "\(fromDateString) - \(toDateString)"
    }
}

extension OneEventInteractor: OneEventInteractorInput {
    func loadRaceInfo() {
        var isUserMember = false
        self.userInteractionsManager.getMember(with: raceId) { isMember, error in
            if let error = error {
                print(error)
                self.output?.showError(error: error)
            }
            
            if let isMember = isMember {
                isUserMember = isMember
            }
        }
        
        self.raceManager.getRace(with: raceId) { race, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    self.output?.showError(error: error)
                }
                if let race = race {
//                    print(race)
                    var isUnabledTobeMember = true
                    
                    if Date().formatted(.iso8601) < race.date.to  {
                        isUnabledTobeMember = true
                    } else {
                        isUnabledTobeMember = false
                    }
                    
                    let location = CLLocation(latitude: race.location.latitude, longitude: race.location.longitude)
                    var cityLoc = ""
                            
                    location.fetchCityAndCountry { city, country, error in
                        guard let city = city, let country = country, error == nil else { return }
                        cityLoc = city
                        
                        let convertedRaceInfo = OneEvent(title: race.name,
                                                dateSubtitle: self.formatDate(dateFrom: race.date.from,
                                                                         dateTo: race.date.to),
                                                latitude: race.location.latitude,
                                                longitude: race.location.longitude,
                                                placeName: cityLoc,
                                                imageId: race.images[safe: 0] ?? "",
                                                description: race.oneRaceDescription,
                                                tags: race.tags,
                                                isMember: isUserMember)
                        self.output?.setRace(races: convertedRaceInfo)
                    }
                }
            }
        }
    }
    
    func addMember() {
        self.userInteractionsManager.postMember(with: raceId) {error in
            if let error = error {
                print(error)
                self.output?.showError(error: error)
            }
            self.output?.setMember()
        }
    }
    
    func deleteMember() {
        self.userInteractionsManager.deleteMember(with: raceId) {error in
            if let error = error {
                print(error)
                self.output?.showError(error: error)
            }
            self.output?.deleteMember()
        }
    }
}
