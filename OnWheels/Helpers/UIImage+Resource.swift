//
//  UIImage+Resource.swift
//  OnWheels
//
//  Created by Veronika on 30.05.2023.
//

import UIKit

extension UIImage {
    private static func image(fromFile name: String) -> UIImage {
        if let path = Bundle.main.path(forResource: name, ofType: "png"),
           let image = UIImage(contentsOfFile: path) {
            return image
        }
        fatalError("Programmer error if image is missing.")
    }
}
