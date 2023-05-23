//
//  EventInfoStackView.swift
//  OnWheels
//
//  Created by Veronika on 29.11.2022.
//

import UIKit
import PinLayout

class EventInfoStackView: UIStackView {
    private let infoImageView: UIImageView = {
        let info = UIImageView()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.contentMode = .scaleAspectFill
        info.layer.masksToBounds = true
        return info
    }()
    
    private let infoLabel: UILabel = {
        let info = UILabel()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.font = UIFont.systemFont(ofSize: 14, weight: .regular)
//        info.textAlignment = .center
        info.textColor = R.color.mainBlue()
        return info
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    func setupUI(){
        self.addArrangedSubview(infoImageView)
        self.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            infoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            infoImageView.heightAnchor.constraint(equalToConstant: 24),
            infoImageView.widthAnchor.constraint(equalToConstant: 24),
            infoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            infoLabel.centerYAnchor.constraint(equalTo: infoImageView.centerYAnchor)
        ])
        
        self.axis = .horizontal
        self.setCustomSpacing(4, after: infoImageView)
    }
    
    func configureForLikes(isLiked: Bool, numberOfLikes: Int) {
        infoImageView.image = isLiked ? R.image.likeTapped() : R.image.likes()
        infoLabel.text = "\(numberOfLikes)"
    }
    
    func configureForParticipants(numberOfParticipants: Int) {
        infoImageView.image = R.image.people()
        infoLabel.text = "\(numberOfParticipants)"
    }
    
    func configureForWatchers(numberOfWatchers: Int) {
        infoImageView.image = R.image.eye()
        infoLabel.text = "\(numberOfWatchers)"
    }
}
