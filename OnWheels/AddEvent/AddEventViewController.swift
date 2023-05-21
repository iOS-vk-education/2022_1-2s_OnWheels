//
//  MyEventsViewController.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 17.11.2022.
//  
//


import UIKit
import PinLayout

final class AddEventViewController: UIViewController {
    private let output: AddEventViewOutput
    
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
    }
    
    override func loadView() {
        view = addRaceContentView
    }
}

extension AddEventViewController: AddEventViewInput {
    func selectImage(image: UIImage?) {
        addRaceContentView.raceImageView.image = image
    }
    
}

private extension AddEventViewController {
    func setupButtonActions() {
        addRaceContentView.setAddAction { [weak self] info in
            self?.output.didTapAddRace(with: info)
        }
        
        addRaceContentView.setCloseAction { [weak self] in
            self?.output.closeButtonWasTapped()
        }
    }
    
    func setupImagePickerAction() {
        addRaceContentView.setPickerAction { [weak self] in
            guard let `self` = self else { return }
            self.output.showImagePicker()
        }
    }
}

