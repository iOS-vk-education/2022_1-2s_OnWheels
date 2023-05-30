//
//  MyEventsPresenter.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//
//

import Foundation

final class AddEventPresenter {
    
    weak var view: AddEventViewInput?
    weak var moduleOutput: AddEventModuleOutput?
    
    private let router: AddEventRouterInput
    private let interactor: AddEventInteractorInput
    
    init(router: AddEventRouterInput, interactor: AddEventInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func getIndexesOfEmptyFields(addRaceInfo: [String?]) -> [Int] {
        var result = [Int]()
        for (index, info) in addRaceInfo.enumerated() {
            guard let info = info else {
                result.append(index)
                continue
            }
            if info.isEmpty {
                result.append(index)
            }
        }
        return result
    }
}

extension AddEventPresenter: AddEventModuleInput {
}

extension AddEventPresenter: AddEventViewOutput {
    func closeButtonWasTapped(with raceInfo: [String?], and imageData: Data?) {
        interactor.saveEventToCoreData(with: raceInfo, and: imageData)
        router.didTapCloseButton()
    }
    
    func didTapAddRace(with raceInfo: [String?], and image: Data?) {
        let emptyFieldsIndexes = getIndexesOfEmptyFields(addRaceInfo: raceInfo)
        if emptyFieldsIndexes.isEmpty {
            interactor.removeEventFromCoreData()
            interactor.addRace(with: raceInfo, and: image)
        } else if !emptyFieldsIndexes.isEmpty{
            view?.showEmptyFields(withIndexes: emptyFieldsIndexes)
        }
    }
    
    func showImagePicker() {
        router.showImagePicker(delegateForPicker: self)
    }
    
    func getDataFromCoreData() {
        interactor.getEventFormCoreData()
    }
}

extension AddEventPresenter: AddEventInteractorOutput {
    func setEventDataFromCoreData(raceData: AddEventInfoCDModel, imageData: Data?) {
        view?.setDataFromCoreData(raceInfo: raceData, imageData: imageData)
    }
    
    func addButtonWasTapped() {
        router.didTapAddButton()
    }
    
    func showError(with error: String) {
        view?.showError(with: error)
    }
}


extension AddEventPresenter: ImagePickerDelegate {
    func didSelect(image imageData: Data?) {
        guard let image = imageData else { return }
        view?.selectImage(imageData: image)
    }
}
