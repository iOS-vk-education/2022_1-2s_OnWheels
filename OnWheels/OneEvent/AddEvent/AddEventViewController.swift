//
//  MyEventsViewController.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//
//


import UIKit

final class AddEventViewController: UIViewController {
    private let output: AddEventViewOutput
    
    private let labels = [R.string.localizable.enterName(), R.string.localizable.dateFrom(),
                          R.string.localizable.dateTo(), R.string.localizable.placeOfEvent(),
                          R.string.localizable.firstTag(), R.string.localizable.secondTag()]
    
    private let addRaceContentView = AddEventContentView()
    
    init(output: AddEventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonActions()
        setupImagePickerAction()
        output.getDataFromCoreData()
    }
    
    override func loadView() {
        view = addRaceContentView
    }
}

extension AddEventViewController: AddEventViewInput {
    func setDataFromCoreData(raceInfo: AddEventInfoCDModel, imageData: Data?) {
        addRaceContentView.setData(from: raceInfo)
        if imageData == nil {
            addRaceContentView.setImage(from: R.image.addRacePicker())
        } else {
            guard let imageData = imageData else {
                return
            }
            let image = UIImage(data: imageData)
            addRaceContentView.setImage(from: image)
        }
    }
    
    func showEmptyFields(withIndexes: [Int]) {
        var alertString = "Не заполены поля: "
        for index in withIndexes {
            if index != withIndexes.last {
                alertString.append(contentsOf: "\(labels[index]), ")
            } else {
                alertString.append(contentsOf: "\(labels[index]).")
            }
        }
        
        let alert = UIAlertController(title: R.string.localizable.alertTitle(),
                                      message: alertString,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertConfirmation(), style: .default))
        self.present(alert, animated: true)
    }
    
    func selectImage(imageData: Data?) {
        guard let image = imageData else { return }
        addRaceContentView.raceImageView.image = UIImage(data: image)
    }
    
    func showError(with error: String) {
        let alert = UIAlertController(title: R.string.localizable.alertTitle(),
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.localizable.alertConfirmation(), style: .default))
        self.present(alert, animated: true)
    }
}

private extension AddEventViewController {
    func setupButtonActions() {
        addRaceContentView.setAddAction { [weak self] info, image in
            self?.output.didTapAddRace(with: info, and: image)
        }
        
        addRaceContentView.setCloseAction { [weak self] info, image in
            self?.output.closeButtonWasTapped(with: info, and: image)
        }
    }
    
    func setupImagePickerAction() {
        addRaceContentView.setPickerAction { [weak self] in
            guard let `self` = self else { return }
            self.output.showImagePicker()
        }
    }
}

