//
// Created by Артём on 24.03.2023.
//

import UIKit

extension UIImageView {
    func makeRounded(width: CGFloat) {
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = false
        layer.cornerRadius = width / 2
        clipsToBounds = true
    }
}
