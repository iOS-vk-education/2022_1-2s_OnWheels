//
//  MyEventsInteractor.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//
//

import Foundation
import CoreData

final class AddEventInteractor {
    weak var output: AddEventInteractorOutput?
    private let raceManager: RacesNetworkManager
    private let locationDecoder: LocationDecoder
    private let imageManager: ImageManager
    private let coreDataManager: AddEventCoreDataManager
    private let imagesFileManager: ImagesFileManager
        
    init(raceManager: RacesNetworkManager, locationDecoder: LocationDecoder, imageManager: ImageManager, coreDataManager: AddEventCoreDataManager, imagesFileManager: ImagesFileManager) {
        self.raceManager = raceManager
        self.locationDecoder = locationDecoder
        self.imageManager = imageManager
        self.coreDataManager = coreDataManager
        self.imagesFileManager = imagesFileManager
    }
    
    private func formatDate(dateFrom: String, dateTo: String) -> (String, String) {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert([.withFractionalSeconds,
                                        .withInternetDateTime])
        let dateStrFrom: [String] = dateFrom.components(separatedBy: ".")
        guard let convertedDateFrom = formatter.date(from: "\(dateStrFrom[2])-\(dateStrFrom[1])-\(dateStrFrom[0])T13:06:38.991Z") else {
            return ("", "")
        }
        
        let convertedDateFromStr = formatter.string(from: convertedDateFrom)
        
        let dateStrTo: [String] = dateTo.components(separatedBy: ".")
        guard let convertedDateTo = formatter.date(from: "\(dateStrTo[2])-\(dateStrTo[1])-\(dateStrTo[0])T13:06:38.991Z") else {
            return ("", "")
        }
        
        let convertedDateToStr = formatter.string(from: convertedDateTo)
        
        return (convertedDateFromStr, convertedDateToStr)
    }
    
    private func makeRaceInfo(raceInfo: [String?], imageId: Int, completion: @escaping(_ race: AddRace?, _ error: String?) -> ()) {
        let raceInfoStrings = raceInfo.compactMap{ $0 }
        
        let date = formatDate(dateFrom: raceInfoStrings[1], dateTo: raceInfoStrings[2])
        
        let raceDate = Duration(from: date.0, to: date.1)
        
        locationDecoder.getLocation(from: raceInfoStrings[3]) { location, error in
            if let error = error {
                self.output?.showError(with: R.string.localizable.locationError())
            } else if let location = location {
                let addRaceInfo = AddRace(name: raceInfoStrings[0],
                                          location: location,
                                          date: raceDate,
                                          addRaceDescription: raceInfoStrings[4],
                                          images: ["https://onwheels.enula.ru/api/Image/\(imageId)"],
                                          tags: [raceInfoStrings[5], raceInfoStrings[6]])
                return completion(addRaceInfo, nil)
            }
        }
    }
}

extension AddEventInteractor: AddEventInteractorInput {
    func saveEventToCoreData(with raceInfo: [String?], and imageData: Data?) {
        coreDataManager.deleteEvent()
        let uuid = UUID().uuidString
        
        let addRaceForCD = AddEventInfoCDModel(uid: uuid,
                                               name: raceInfo[0] ?? "",
                                               loction: raceInfo[3] ?? "",
                                               dateFrom: raceInfo[1] ?? "",
                                               dateTo: raceInfo[2] ?? "",
                                               raceDescription: raceInfo[4] ?? "",
                                               firstTag: raceInfo[5] ?? "",
                                               secondTag: raceInfo[6] ?? "")
        
        imagesFileManager.saveImageLocally(imageData: imageData, fileName: addRaceForCD.uid)
        coreDataManager.addNewEvent(addRaceForCD)
    }
    
    func getEventFormCoreData() {
        let events = coreDataManager.fetchEvents()
        guard let event = events.last else {
            return
        }
        
        let imageData = imagesFileManager.getImageFromName(fileName: event.uid)
        output?.setEventDataFromCoreData(raceData: event, imageData: imageData)
    }
    
    func removeEventFromCoreData() {
        coreDataManager.deleteEvent()
    }
    
    func removeDataFromTFs() {
        output?.cleanTFs()
    }
    
    func addRace(with raceInfo: [String?], and imageData: Data?) {
        if let image = imageData {
            imageManager.postImage(with: image) {imageData, error in
                if let error = error {
                    self.output?.showError(with: error)
                } else {
                    guard let imageId = imageData?.imageId else {
                        return
                    }
                    
                    let convertedInfo = self.makeRaceInfo(raceInfo: raceInfo, imageId: imageId) { race, error in
                        if let error = error {
                            print("error")
                            self.output?.showError(with: error)
                        }
                        
                        if let convertedRaceInfo = race {
                            self.raceManager.postRace(with: convertedRaceInfo) { error in
                                if let error = error {
                                    print(error)
                                    self.output?.showError(with: error)
                                } else {
                                    self.output?.addButtonWasTapped()
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

