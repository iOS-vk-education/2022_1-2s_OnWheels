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
    private let contentProvider: EventsContentProvider
    private let userInteractionsManager: UserInteractionNetworkManager

    
    init(raceManager: RacesNetworkManager, contentProvider: EventsContentProvider, userInteractionsManager: UserInteractionNetworkManager) {
        self.raceManager = raceManager
        self.contentProvider = contentProvider
        self.userInteractionsManager = userInteractionsManager
    }
    
    func updateRaces(with raceInfo: [RaceInfo]?) {
        if let raceInfo = raceInfo {
            DispatchQueue.main.async {
                self.output?.setRaces(races: raceInfo)
            }
        }
    }
    
    private func makeRaceInfo(raceList: RaceList) -> [RaceInfo] {
        var raceInfo: [RaceInfo] = []
        
        for elem in raceList {
            let race = RaceInfo(id: elem.raceId,
                                title: elem.name,
                                dateSubtitle: formatDate(dateFrom: elem.date.from,
                                                         dateTo: elem.date.to),
                                imageId: elem.images[safe: 0] ?? "",
                                numberOfLikes: elem.likes,
                                numberOfParticipants: elem.members.count,
                                numberOfWatchers: elem.views,
                                isLiked: elem.isLiked)
            raceInfo.insert(race, at: 0)
        }
        
        return raceInfo
    }
    
    private func formatDate(dateFrom: String, dateTo: String) -> String {
        var fromDateString = ""
        var toDateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.eventCellApiDateFormat
        inputFormatter.locale = Locale(identifier: "ru_RU_POSIX")
        if let dateFrom = inputFormatter.date(from: dateFrom) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "ru_RU_POSIX")
            fromDateString = outputFormatter.string(from: dateFrom)
            fromDateString = fromDateString.capitalized
        } else {
            fromDateString = "Error"
        }
        
        if let dateTo = inputFormatter.date(from: dateTo) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.eventCellDateFormat
            outputFormatter.locale = Locale(identifier: "ru_RU_POSIX")
            toDateString = outputFormatter.string(from: dateTo)
            toDateString = toDateString.capitalized
        }
        
        return "\(fromDateString) - \(toDateString)"
    }
}

extension EventsInteractor: EventsInteractorInput {
    func getEvent(by index: Int) -> RaceInfo {
        return contentProvider.getEvent(with: index)
    }
    
    func loadRaces(){
        raceManager.getListOfRaces { races, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }
                if let races = races {
                    let convertedRaces = self.makeRaceInfo(raceList: races)
                    self.contentProvider.insertEvents(with: convertedRaces)
                    self.output?.setRaces(races: convertedRaces)
                }
            }
        }
    }
    
    func setLike(for raceId: Int){
        userInteractionsManager.postLike(with: raceId) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    print("liked race_id: ", raceId)
                    self.output?.setLike(raceId: raceId)
                }
            }
        }
    }
    
    func setView(for raceId: Int) {
        userInteractionsManager.postView(with: raceId) { error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                } else {
                    print("viewed race_id: ", raceId)
                    self.output?.setViews(raceId: raceId)
                }
            }
        }
    }
}
