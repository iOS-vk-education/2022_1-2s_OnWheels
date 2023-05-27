//
//  LoaderView.swift
//  OnWheels
//
//  Created by Veronika on 24.05.2023.
//

import Foundation
import Lottie
import RswiftResources

final class LoaderView: UIView {
    let loaderAnimationView: LottieAnimationView = {
        let animation = LottieAnimationView()
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.loopMode = .autoReverse
        return animation
    }()
    
    private let loaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.loader()
        label.textColor = R.color.mainOrange()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    init(animationName: String) {
        super.init(frame: .zero)
        self.backgroundColor = R.color.background()
        self.loaderAnimationView.animation = LottieAnimation.named(animationName)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LoaderView {
    private func setupConstraints() {
        self.addSubview(loaderAnimationView)
        self.addSubview(loaderLabel)
        
        NSLayoutConstraint.activate([
            loaderAnimationView.topAnchor.constraint(equalTo: self.topAnchor),
            loaderAnimationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loaderAnimationView.widthAnchor.constraint(equalToConstant: 200),
            loaderAnimationView.heightAnchor.constraint(equalToConstant: 200),
            
            loaderLabel.topAnchor.constraint(equalTo: loaderAnimationView.bottomAnchor, constant: 0),
            loaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func startAnimation() {
        loaderAnimationView.play()
    }
}
