//
//  LogInViewController.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit

final class LogInViewController: UIViewController {
	private let output: LogInViewOutput

    init(output: LogInViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension LogInViewController: LogInViewInput {
}
