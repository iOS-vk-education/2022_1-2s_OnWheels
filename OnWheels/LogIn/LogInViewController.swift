//
//  LogInViewController.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit
import PinLayout

class СustomTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .roundedRect
        self.backgroundColor = .secondarySystemBackground
        self.font = .systemFont(ofSize: 13)
        self.layer.borderColor = UIColor.systemGray3.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

final class LogInViewController: UIViewController {
    private let output: LogInViewOutput
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let image: UIImage = UIImage(named: R.image.loginPic.name) ?? .init()
        let startImage = CIImage(image: image)
        if traitCollection.userInterfaceStyle == .dark {
            let filter = CIFilter(name: "CIColorInvert")
            filter?.setValue(startImage, forKey: kCIInputImageKey)
            let newImage = UIImage(ciImage: filter?.outputImage ?? .empty())
            bikeImage.image = newImage
        } else {
            bikeImage.image = image
        }
    }
    
    private(set) lazy var bikeImage: UIImageView = {
        let image: UIImage = UIImage(named: R.image.loginPic.name) ?? .init()
        let i: UIImageView = .init(image: image)
        if traitCollection.userInterfaceStyle == .dark {
            let startImage = CIImage(image: image)
            let filter = CIFilter(name: "CIColorInvert")
            filter?.setValue(startImage, forKey: kCIInputImageKey)
            let newImage = UIImage(ciImage: filter?.outputImage ?? .empty())
            i.image = newImage
        }
        i.contentMode = .scaleAspectFit
        return i
    }()
    
    private(set) lazy var scrollView: UIScrollView = {
        let s: UIScrollView = .init()
        s.isScrollEnabled = false
        return s
    }()
    
    private(set) lazy var welcomeLabel: UILabel = {
        let l: UILabel = .init()
        l.text = R.string.localizable.welcomeText()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 24, weight: .medium)
        l.textAlignment = .center
        return l
    }()
    
    private(set) lazy var loginField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterEmail()
        return t
    }()
    
    private(set) lazy var passField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterPassword()
        return t
    }()
    
    private(set) lazy var forgotPassButton: UIButton = {
        let b: UIButton = .init()
        let attrString = NSAttributedString(string: R.string.localizable.forgotPassword(),
                                            attributes:[
                                                .underlineStyle: NSUnderlineStyle.single.rawValue,
                                                .font: UIFont.systemFont(ofSize: 13),
                                                .foregroundColor: UIColor.systemBlue])
        b.setAttributedTitle(attrString, for: .normal)
        return b
    }()
    
    private(set) lazy var enterButton: UIButton = {
        let b: UIButton = .init(configuration: .filled())
        b.titleLabel?.font = .systemFont(ofSize: 20)
        b.setTitle(R.string.localizable.enter(), for: .normal)
        return b
    }()
    
    private(set) lazy var regButton: UIButton = {
        let b: UIButton = .init()
        var attrString0 = NSMutableAttributedString(string: R.string.localizable.noAccount(),
                                                    attributes:[
                                                        .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: R.string.localizable.register(),
                                             attributes:[
                                                .font: UIFont.systemFont(ofSize: 15),
                                                .foregroundColor: UIColor.systemBlue])
        attrString0.append(attrString1)
        b.setAttributedTitle(attrString0, for: .normal)
        return b
    }()
    
    private(set) lazy var skipLoginButton: UIButton = {
        let b: UIButton = .init()
        var attrString0 = NSMutableAttributedString(string: R.string.localizable.or(),
                                                    attributes:[
                                                        .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: R.string.localizable.loginWithoutAccount(),
                                             attributes:[
                                                .font: UIFont.systemFont(ofSize: 15),
                                                .foregroundColor: UIColor.systemBlue])
        attrString0.append(attrString1)
        b.setAttributedTitle(attrString0, for: .normal)
        b.titleLabel?.textAlignment = .center
        b.titleLabel?.numberOfLines = 0
        return b
    }()
    
    
    init(output: LogInViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            scrollView.contentOffset.y = keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.contentOffset.y = .zero
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubviews(bikeImage, welcomeLabel, loginField,
                               passField, forgotPassButton, enterButton,
                               regButton, skipLoginButton)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        setupBinding()
    }
    
    private func setupBinding() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        
        enterButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        regButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        skipLoginButton.addTarget(self, action: #selector(didTapSkipLoginButton), for: .touchUpInside)
    }
    
    @objc
    private func didTapSkipLoginButton() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.skipLoginButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapNoAccountButton()
                self?.skipLoginButton.alpha = 1
            }
        }
    }
    
    @objc
    private func didTapLoginButton() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.enterButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapLoginButton()
                self?.enterButton.alpha = 1
            }
        }
    }
    
    @objc
    private func didTapRegButton() {
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.regButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapRegButton()
                self?.regButton.alpha = 1
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.pin
            .all(view.pin.safeArea)
        
        skipLoginButton.pin
            .bottom()
            .marginBottom(8)
            .hCenter()
            .height(Constants.skipLoginButton.height)
            .sizeToFit(.height)
        
        regButton.pin
            .above(of: skipLoginButton)
            .marginTop(Constants.regTextButton.marginTop)
            .hCenter()
            .height(Constants.regTextButton.height)
            .sizeToFit(.height)
        enterButton.pin
            .above(of: regButton)
            .left()
            .right()
            .margin(Constants.block.marginTop,
                    Constants.block.marginHorizontal,
                    Constants.block.marginBottom)
            .height(Constants.block.height)
        
        forgotPassButton.pin
            .above(of: enterButton)
            .marginBottom(Constants.forgotPassButton.marginTop)
            .right(Constants.forgotPassButton.marginRight)
            .sizeToFit(.height)
        
        passField.pin
            .above(of: forgotPassButton)
            .left()
            .right()
            .margin(Constants.block.marginTop,
                    Constants.block.marginHorizontal,
                    Constants.block.marginBottom)
            .height(Constants.block.height)
        
        loginField.pin
            .above(of: passField)
            .left()
            .right()
            .margin(Constants.block.marginTop,
                    Constants.block.marginHorizontal,
                    Constants.block.marginBottom)
            .height(Constants.block.height)
        
        welcomeLabel.pin
            .above(of: loginField)
            .marginBottom(Constants.welcomeLabel.marginTop)
            .hCenter()
            .sizeToFit()
        
        bikeImage.pin
            .top()
            .above(of: welcomeLabel)
            .hCenter()
        
    }
}

extension LogInViewController: LogInViewInput {
}

private struct Constants {
    
    struct welcomeLabel {
        static let marginTop: CGFloat = 21
    }
    
    struct block {
        static let marginTop: CGFloat = 21
        static let marginHorizontal: CGFloat = 43
        static let marginBottom: CGFloat = 21
        static let height: CGFloat = 42
    }
    
    struct forgotPassButton {
        static let marginTop: CGFloat = 21
        static let marginRight: CGFloat = 43
        static let width: CGFloat = 105
    }
    
    struct regTextButton {
        static let marginTop: CGFloat = 16
        static let height: CGFloat = 18
    }
    
    struct skipLoginButton {
        static let height: CGFloat = 36
    }
}
