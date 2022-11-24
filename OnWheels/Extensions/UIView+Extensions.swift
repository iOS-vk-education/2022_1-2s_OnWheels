//
//  UIView+Extensions.swift
//  OnWheels
//
//  Created by Илья on 11/5/22.
//

import UIKit

extension UIView {
    func addSubviews(_ subview: UIView...) {
        subview.forEach(addSubview)
    }
}
