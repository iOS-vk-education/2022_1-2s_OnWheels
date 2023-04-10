//
// Created by Артём on 03.04.2023.
//
import UIKit


extension UIButton {
    static func basicButtonConf() -> UIButton.Configuration {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        config.titlePadding = 5
        config.imagePadding = 5
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        config.background.cornerRadius = 20
        return config
    }

    static func largeButtonConf() -> UIButton.Configuration {
        var config = UIButton.Configuration.borderedTinted()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.baseBackgroundColor = .white
        config.background.cornerRadius = 15
        config.background.strokeWidth = 1
        config.imagePadding = 5
    //...
        return config
    }
}
