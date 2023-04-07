//
// Created by Артём on 03.04.2023.
//
import UIKit


extension UIButton {
    func basicButtonConf() -> UIButton.Configuration {
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
        self.layer.cornerRadius = 20
        return config
    }

    func largeButtonConf() -> UIButton.Configuration {
        var config = UIButton.Configuration.tinted()
        //...
        return config
    }
}
