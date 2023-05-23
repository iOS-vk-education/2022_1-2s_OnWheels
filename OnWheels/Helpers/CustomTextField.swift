//
//  CustomTextField.swift
//  OnWheels
//
//  Created by Veronika on 19.12.2022.
//

import UIKit
class СustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .roundedRect
        self.backgroundColor = .secondarySystemBackground
        self.font = .systemFont(ofSize: 13)
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.spellCheckingType = .no
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setupTextField(with placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: R.color.textFieldText()])
    }
    
    func setupInputView(with inputView: UIView?) {
        self.inputView = inputView
    }
    
    func setupText(with text: String) {
        self.text = text
    }
}
