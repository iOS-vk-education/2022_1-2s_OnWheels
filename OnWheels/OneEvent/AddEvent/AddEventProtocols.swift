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
}

protocol AddEventViewOutput: AnyObject {
    func closeButtonWasTapped()
    func didTapAddRace(with raceInfo: [String?], and imageData: Data?)
    func showImagePicker()
}

protocol AddEventInteractorInput: AnyObject {
    func addRace(with raceInfo: [String?], and imageData: Data?)
}

protocol AddEventInteractorOutput: AnyObject {
    func addButtonWasTapped()
    func showError(with error: String)
}

protocol AddEventRouterInput: AnyObject {
    func didTapCloseButton()
    func didTapAddButton()
    func showImagePicker(delegateForPicker delegate: ImagePickerDelegate)
}
