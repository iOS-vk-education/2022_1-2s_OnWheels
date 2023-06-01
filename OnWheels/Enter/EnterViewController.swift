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
    let timeInterval = 3.0
    
    init(output: EnterViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.launchScreenColor()
        showLoader(animationName: R.file.loaderAnimationJson.name)
        scaleLoader(scaleCoeff: 1.8)
        timer = Timer.scheduledTimer(timeInterval: timeInterval,
                                     target: self,
                                     selector: #selector(nextView),
                                     userInfo: nil, repeats: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    @objc
    func nextView(){
        hideLoader()
        output.showNextScreen()
    }
}

extension EnterViewController: EnterViewInput {
}

extension EnterViewController {
    func setupLayout(){
    }

}
