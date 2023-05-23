//
//  CustomMainButton.swift
//  OnWheels
//
//  Created by Veronika on 05.04.2023.
//

import UIKit

class MainAppButton: BaseButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBackgroundColor()
        setFont()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setBackgroundColor() {
        self.configuration = .filled()
        self.tintColor = R.color.mainBlue()
    }
    
    func setFont() {
        self.configuration?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            return outgoing
        }
    }
    
    func setupTitle(with text: String) {
        self.setTitle(text, for: .normal)
    }
}
