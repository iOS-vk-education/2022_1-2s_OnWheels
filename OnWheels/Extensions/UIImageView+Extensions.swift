//
// Created by Артём on 24.03.2023.
//

import UIKit

extension UIImageView {
    func makeRounded() {
        layer.borderWidth = 1
        layer.masksToBounds = false
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}