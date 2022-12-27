//
//  EventTagView.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//

import UIKit
import PinLayout

final class EventTagView: UIView {
    let eventTagLabel: UILabel = {
        let eventTag = UILabel()
        eventTag.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        eventTag.textColor = R.color.mainBlue()
        eventTag.textAlignment = .center
        return eventTag
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.eventTagBackground()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    private func setupLayout(){
        self.addSubview(eventTagLabel)
        self.pin
            .height(20)
            .sizeToFit(.height)
        eventTagLabel.pin
            .left()
            .top()
            .right()
            .bottom()
    }
    
    func configureTag(with text: String){
        eventTagLabel.text = text
    }
}


