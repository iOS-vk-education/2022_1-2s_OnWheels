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
        config.imagePadding = 15
    //...
        return config
    }
}


final class CustomButton: UIView {
    typealias Action = () -> ()

    private var action: Action?

    let actionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    let actionImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = R.color.cellColor()
        setupViews()
        setupConstraints()
        setupGestureRecognizer()
    }

    required init?(coder: NSCoder) {
        nil
    }
}

extension CustomButton {
    private func setupViews() {
        self.addSubview(actionLabel)
        self.addSubview(actionImageView)
    }

    private func setupConstraints() {
        actionLabel.top(12, isIncludeSafeArea: false)
        actionLabel.leading(12)
        actionLabel.trailing(-70)

        NSLayoutConstraint.activate([
            actionImageView.topAnchor.constraint(equalTo: actionLabel.topAnchor),
            actionImageView.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -36)
        ])
        actionImageView.trailing(-12)
        actionImageView.width(24)
        actionImageView.height(24)
    }

    func setupGestureRecognizer() {
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(gestureRecognizerAction)))
    }

    @objc
    func gestureRecognizerAction(){
        action?()
    }

    func setprofileAction(_ action: @escaping Action) {
        self.action = action
    }

    func configureViewWith(text: String, textColor: UIColor?, image: UIImage?) {
        actionLabel.text = text
        actionLabel.textColor = textColor
        actionImageView.image = image
    }

    func changeActionImage(image: UIImage?) {
        UIView.animate(withDuration: 0.2) {
            self.actionImageView.image = image
        }
    }
}

