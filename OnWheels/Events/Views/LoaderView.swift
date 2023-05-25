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
    
    private let loaderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.loader()
        label.textColor = R.color.mainOrange()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
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
        self.addSubview(loaderLabel)
        
        NSLayoutConstraint.activate([
            loaderAnimationView.topAnchor.constraint(equalTo: self.topAnchor),
            loaderAnimationView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            loaderAnimationView.widthAnchor.constraint(equalToConstant: 200),
            loaderAnimationView.heightAnchor.constraint(equalToConstant: 200),
            
            loaderLabel.topAnchor.constraint(equalTo: loaderAnimationView.bottomAnchor, constant: -20),
            loaderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func startAnimation() {
        loaderAnimationView.play()
    }
}
