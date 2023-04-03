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
    }
    
    override func loadView() {
        view = addRaceContentView
    }
}

extension AddEventViewController: AddEventViewInput {
}

private extension AddEventViewController {
    
}

