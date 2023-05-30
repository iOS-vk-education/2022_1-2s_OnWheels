//
//  MyEventsProtocols.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//
//

import Foundation

protocol AddEventModuleInput {
    var moduleOutput: AddEventModuleOutput? { get }
}

protocol AddEventModuleOutput: AnyObject {
}

protocol AddEventViewInput: AnyObject {
    func selectImage(imageData: Data?)
    func showError(with error: String)
    func showEmptyFields(withIndexes: [Int])
    func setDataFromCoreData(raceInfo: AddEventInfoCDModel)
}

protocol AddEventViewOutput: AnyObject {
    func closeButtonWasTapped(with raceInfo: [String?], and imageData: Data?)
    func didTapAddRace(with raceInfo: [String?], and imageData: Data?)
    func showImagePicker()
    func getDataFromCoreData()
}

protocol AddEventInteractorInput: AnyObject {
    func addRace(with raceInfo: [String?], and imageData: Data?)
    func saveEventToCoreData(with raceInfo: [String?], and imageData: Data?)
    func removeEventFromCoreData()
    func getEventFormCoreData()
}

protocol AddEventInteractorOutput: AnyObject {
    func addButtonWasTapped()
    func showError(with error: String)
    func setEventDataFromCoreData(raceData: AddEventInfoCDModel)
}

protocol AddEventRouterInput: AnyObject {
    func didTapCloseButton()
    func didTapAddButton()
    func showImagePicker(delegateForPicker delegate: ImagePickerDelegate)
}
