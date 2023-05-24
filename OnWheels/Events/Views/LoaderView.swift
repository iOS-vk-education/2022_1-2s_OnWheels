//
//  LoaderView.swift
//  OnWheels
//
//  Created by Veronika on 24.05.2023.
//

import Foundation
import Lottie

final class LoaderView: UIView {
    private let loaderAnimationView: LottieAnimationView = {
        let animation = LottieAnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.animation = LottieAnimation.named(JSONEnum.animation.rawValue)
        animation.loopMode = .autoReverse
        return animation
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.background()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LoaderView {
    private func setupConstraints() {
        self.addSubview(loaderAnimationView)
        
        NSLayoutConstraint.activate([
            loaderAnimationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loaderAnimationView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loaderAnimationView.widthAnchor.constraint(equalToConstant: 100),
            loaderAnimationView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func startAnimation() {
        loaderAnimationView.play()
    }
    
    func stopAnimation() {
        loaderAnimationView.stop()
    }
}
