//
//  UIStackView+Extensions.swift
//  OnWheels
//
//  Created by Илья on 11/5/22.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subview: UIView...) {
        subview.forEach(addArrangedSubview)
    }
}
