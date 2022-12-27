//
//  EventInfoStackView.swift
//  OnWheels
//
//  Created by Veronika on 29.11.2022.
//

import UIKit
import PinLayout

class EventInfoStackView: UIStackView {
    let infoImageView: UIImageView = {
        let info = UIImageView()
        info.contentMode = .scaleAspectFill
        info.layer.masksToBounds = true
        return info
    }()
    
    let infoLabel: UILabel = {
        let info = UILabel()
        info.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        info.textAlignment = .center
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
        infoImageView.pin
            .top()
            .left()
            .bottom()
            .height(24)
            .width(24)
        infoLabel.pin
            .vCenter()
        
        self.axis = .horizontal
        self.setCustomSpacing(4, after: infoImageView)
    }
    
    func configureStackVeiw(image: String, text: String){
        let image = UIImage(named: image)
        infoImageView.image = image
        infoLabel.text = text
    }
}
