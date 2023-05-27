//
//  TabBarCenterButton.swift
//  OnWheels
//
//  Created by Veronika on 27.05.2023.
//

import UIKit

final class TabBarCenterButton: UIButton {
    private let buttonImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.image.jumpButton()
        image.layer.borderWidth = 1
        image.layer.borderColor = R.color.mainOrange()?.cgColor
        image.layer.cornerRadius = 32
        image.clipsToBounds = true
        image.layer.shadowRadius = 2
        return image
    }()

    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = R.string.localizable.addRace()
        label.textColor = R.color.mainBlue()
        label.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }, completion: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.curveEaseOut], animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
    }
}

private extension TabBarCenterButton {
    func setupButton() {
        self.addSubview(buttonImageView)
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonImageView.heightAnchor.constraint(equalToConstant: 64),
            buttonImageView.widthAnchor.constraint(equalToConstant: 64)
        ])

        self.addSubview(buttonLabel)
        NSLayoutConstraint.activate([
            buttonLabel.topAnchor.constraint(equalTo: buttonImageView.bottomAnchor, constant: 6),
            buttonLabel.centerXAnchor.constraint(equalTo: buttonImageView.centerXAnchor)
        ])
    }
}

