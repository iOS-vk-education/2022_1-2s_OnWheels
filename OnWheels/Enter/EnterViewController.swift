//
//  EnterViewController.swift
//  OnWheels
//
//  Created by Veronika on 10.11.2022.
//  
//

import UIKit
import PinLayout

final class EnterViewController: UIViewController {
    private let output: EnterViewOutput
    
    var timer = Timer()
    let timeInterval = 5.0
    
    let lauchImage: UIImageView = {
        let image = UIImageView()
        image.image = R.image.launchImage()
        return image
    }()
    
    let progressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .bar)
        progress.progressTintColor = .mainOrangeColor
        progress.trackTintColor = .secondarySystemBackground
        progress.layer.cornerRadius = 6
        progress.clipsToBounds = true
        progress.progress = 0
        progress.heightAnchor.constraint(equalToConstant: 7)
        return progress
    }()
    
    init(output: EnterViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(nextView),
                                     userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupProgressView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    @objc
    func nextView(){
        output.showNextScreen()
    }
}

extension EnterViewController: EnterViewInput {
}

extension EnterViewController {
    func setupLayout(){
        view.addSubview(lauchImage)
        lauchImage.pin
            .center()
            .height(Constants.LauchImage.heightPercent)
            .width(Constants.LauchImage.widthPercent)
        
        view.addSubview(progressView)
        progressView.pin
            .width(Constants.ProgressView.width)
            .height(Constants.ProgressView.height)
            .top(to: lauchImage.edge.bottom)
            .marginTop(Constants.ProgressView.marginTop)
            .hCenter(to: lauchImage.edge.hCenter)
    }
    
    func setupProgressView(){
        UIView.animate(withDuration: 5.0) {
            self.progressView.setProgress(1.0, animated: true)
        }
    }
    
    struct Constants {
        struct LauchImage {
            static let widthPercent: Percent = 65%
            static let heightPercent: Percent = 45%
        }
        
        struct ProgressView {
            static let marginTop: CGFloat = 50
            static let height: CGFloat = 10
            static let width: CGFloat = 250
        }
    }
}
