//
//  LoaderView.swift
//  OnWheels
//
//  Created by Veronika on 24.05.2023.
//

import Foundation
import Lottie
import RswiftResources
import SnapKit

final class LoaderView: UIView {
    var heightConstraint: Constraint!
    var widthConstraint: Constraint!

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

        loaderAnimationView.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(200).constraint
            widthConstraint = make.width.equalTo(200).constraint
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        loaderLabel.snp.makeConstraints { make in
            make.top.equalTo(loaderAnimationView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }
    
    func startAnimation() {
        loaderAnimationView.play()
    }

    func scaleConstraints(scaleCoeff: Double) {
        heightConstraint.deactivate()
        widthConstraint.deactivate()
        loaderAnimationView.snp.makeConstraints { make in
            heightConstraint = make.height.equalTo(200 * scaleCoeff).constraint
            widthConstraint = make.width.equalTo(200 * scaleCoeff).constraint
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
