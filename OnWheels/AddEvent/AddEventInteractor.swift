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
    private let imageManager: ImageManager
    
    init(raceManager: RacesNetworkManager, locationDecoder: LocationDecoder, imageManager: ImageManager) {
        self.raceManager = raceManager
        self.locationDecoder = locationDecoder
        self.imageManager = imageManager
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
                print("\(error.localizedDescription)")
            } else if let location = location {
                let addRaceInfo = AddRace(name: raceInfoStrings[0],
                                          location: location,
                                          date: raceDate,
                                          addRaceDescription: raceInfoStrings[4],
                                          images: ["https://onwheels.enula.ru/api/Image/\(imageId)"],
                                          tags: [])
                return completion(addRaceInfo, nil)
            }
        }
    }
}

extension AddEventInteractor: AddEventInteractorInput {
    func addRace(with raceInfo: [String?], and imageData: Data?) {
        
        var imageResult: (imageData: ImageModel?, error: String?)? = nil
        if let image = imageData {
            imageManager.postImage(with: image) {imageData, error in
                if error != nil {
                    print(error)
                } else {
                    guard let imageId = imageData?.imageId else {
                        return
                    }
                    
                    let convertedInfo = makeRaceInfo(raceInfo: raceInfo, imageId: imageId) {
                        
                    }
                }
            }
        }
        
        
//        let raceInfoStrings = raceInfo.compactMap{ $0 }
//
//        // TODO: сделать с помощью экстеншена Артема перевод времени из строки
//        let raceDate = Duration(from: "2023-04-10T08:18:45.754Z", to: "2023-04-10T08:18:45.754Z")
//
//        locationDecoder.getLocation(from: raceInfoStrings[3]) { location, error in
//            if let error = error {
//                print("Ошибка получения координат: \(error.localizedDescription)")
//            } else if let location = location {
//                let addRaceModel = AddRace(name: raceInfoStrings[0],
//                                           location: location,
//                                           date: raceDate,
//                                           addRaceDescription: raceInfoStrings[4],
//                                           images: [""],
//                                           tags: [""])
//                self.raceManager.postRace(with: addRaceModel) { error in
//                    if error == nil {
//                        self.output?.addButtonWasTapped()
//                    } else {
//                        print(error)
//                    }
//                }
//            }
//        }
    }
}

