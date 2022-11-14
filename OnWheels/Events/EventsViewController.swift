//
//  EventsViewController.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import UIKit

final class EventsViewController: UIViewController {
    private let output: EventsViewOutput
    
    init(output: EventsViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

extension EventsViewController: EventsViewInput {
}
