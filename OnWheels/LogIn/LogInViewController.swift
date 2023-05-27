//
//  LogInViewController.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit
import PinLayout


final class LogInViewController: UIViewController {
    private let output: LogInViewOutput
    
    let fields = ["Почта", "Пароль"]
    
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
        t.autocapitalizationType = .none
        return t
    }()
    
    private(set) lazy var passField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterPassword()
        t.isSecureTextEntry = true
        t.autocapitalizationType = .none
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
    
    private(set) lazy var enterButton = MainAppButton()
    
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
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardHeight = keyboardSize.cgRectValue.height
        if scrollView.frame.origin.y == 0 {
            UIView.animate(withDuration: 0.3){ [weak self] in
                self?.scrollView.frame.origin.y -= keyboardHeight
                self?.view.layoutIfNeeded()
            }
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        scrollView.frame.origin.y = 0
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
        setupObserversForKeyboard()
        setupBinding()
        setupTitleForEnterButton()
    }
    
    @objc
    private func didTapSkipLoginButton() {
        view.endEditing(true)
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
        view.endEditing(true)
        guard let email = loginField.text, let password = passField.text else {
            return
        }
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.enterButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.didTapLoginButton(email: email, password: password)
                self?.enterButton.alpha = 1
            }
        }
    }
    
    @objc
    private func didTapRegButton() {
        view.endEditing(true)
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
        setupLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObserversForKeyboard()
    }
}

private extension LogInViewController {
    func setupTitleForEnterButton() {
        enterButton.setupTitle(with: R.string.localizable.enter())
    }
    func setupObserversForKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeObserversForKeyboard(){
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: self.view.window)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: self.view.window)
    }
    
    func setupBinding() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        
        enterButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        regButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
        skipLoginButton.addTarget(self, action: #selector(didTapSkipLoginButton), for: .touchUpInside)
    }
    
    func setupLayout() {
        scrollView.pin
            .top()
            .left()
            .right()
            .bottom()
        
        bikeImage.pin
            .top(to: scrollView.edge.top)
            .marginTop(-20)
            .hCenter()
            .height(Constants.BikeImage.height)
        
        welcomeLabel.pin
            .top(to: bikeImage.edge.bottom)
            .marginTop(Constants.WelcomeLabel.marginTop)
            .hCenter()
            .sizeToFit()
        
        loginField.pin
            .top(to: welcomeLabel.edge.bottom)
            .left()
            .right()
            .margin(Constants.Block.marginTop,
                    Constants.Block.marginHorizontal,
                    Constants.Block.marginBottom)
            .height(Constants.Block.height)
        
        passField.pin
            .top(to: loginField.edge.bottom)
            .left()
            .right()
            .margin(Constants.Block.marginTop,
                    Constants.Block.marginHorizontal,
                    Constants.Block.marginBottom)
            .height(Constants.Block.height)
        
        forgotPassButton.pin
            .top(to: passField.edge.bottom)
            .marginTop(Constants.ForgotPassButton.marginTop)
            .right(Constants.ForgotPassButton.marginRight)
            .sizeToFit(.height)
        
        enterButton.pin
            .top(to: forgotPassButton.edge.bottom)
            .left()
            .right()
            .margin(Constants.Block.marginTop,
                    Constants.Block.marginHorizontal,
                    Constants.Block.marginBottom)
            .height(Constants.Block.height)
        
        regButton.pin
            .top(to: enterButton.edge.bottom)
            .marginTop(Constants.RegTextButton.marginTop)
            .hCenter()
            .height(Constants.RegTextButton.height)
            .sizeToFit(.height)
        
        skipLoginButton.pin
            .top(to: regButton.edge.bottom)
            .marginTop(Constants.SkipLoginButton.marginTop)
            .hCenter()
            .height(Constants.SkipLoginButton.height)
            .sizeToFit(.height)
    }
}

extension LogInViewController: LogInViewInput {
    func showEmptyFields(withIndexes indexes: [Int]){
        var emptyFields = ""
        for index in indexes {
            emptyFields.append("\(fields[index]), ")
        }
        let alert = UIAlertController(title: "Ой", message: "Проверьте заполненность полей: \(emptyFields)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Исправлю", style: .default))
        self.present(alert, animated: true)
    }
    
    func showNonAuthorized(with error: String) {
        let alert = UIAlertController(title: "Ой", message: "\(error)", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Исправлю", style: .default))
        self.present(alert, animated: true)
    }
}

private struct Constants {
    
    struct WelcomeLabel {
        static let marginTop: CGFloat = 0
    }
    
    struct BikeImage {
        static let height: Percent = 50%
    }
    
    struct Block {
        static let marginTop: CGFloat = 21
        static let marginHorizontal: CGFloat = 43
        static let marginBottom: CGFloat = 21
        static let height: CGFloat = 42
    }
    
    struct ForgotPassButton {
        static let marginTop: CGFloat = 21
        static let marginRight: CGFloat = 43
        static let width: CGFloat = 105
    }
    
    struct RegTextButton {
        static let marginTop: CGFloat = 16
        static let height: CGFloat = 18
    }
    
    struct SkipLoginButton {
        static let height: CGFloat = 36
        static let marginTop: CGFloat = 8
    }
}
