//
//  LogInViewController.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit
import PinLayout

final class LogInViewController: UIViewController {
	private let output: LogInViewOutput

    private(set) lazy var bikeImage: UIImageView = {
        let image: UIImage = UIImage(named: "loginPic") ?? .init()
        let i: UIImageView = .init(image: image)
        return i
    }()

    private(set) lazy var scrollView: UIScrollView = {
        let s: UIScrollView = .init()
        return s
    }()

    private(set) lazy var welcomeLabel: UILabel = {
        let l: UILabel = .init()
        l.text = "Добро пожаловать в \n MotoCom"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 24, weight: .medium)
        l.textAlignment = .center
        return l
    }()

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
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubview(bikeImage)
        scrollView.addSubview(welcomeLabel)
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.pin.all(view.pin.safeArea)

        bikeImage.pin
            .top()
            .left()
            .right()

        welcomeLabel.pin
            .below(of: bikeImage)
            .marginTop(-40)
            .hCenter()
            .sizeToFit()

    }
}

extension LogInViewController: LogInViewInput {
}
