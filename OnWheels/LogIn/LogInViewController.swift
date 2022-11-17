//
//  LogInViewController.swift
//  OnWheels
//
//  Created by Илья on 10/25/22.
//  
//

import UIKit
import PinLayout

class customTextField: UITextField {
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
        fatalError("init(coder:) has not been implemented")
    }
}

final class LogInViewController: UIViewController {
	private let output: LogInViewOutput

    private(set) lazy var bikeImage: UIImageView = {
        let image: UIImage = UIImage(named: "loginPic") ?? .init()
        let i: UIImageView = .init(image: image)
        i.contentMode = .scaleAspectFit
        return i
    }()

    private(set) lazy var scrollView: UIScrollView = {
        let s: UIScrollView = .init()
        s.contentSize = .init(width: view.frame.size.width, height: view.frame.size.height)
        s.isScrollEnabled = false
        return s
    }()

    private(set) lazy var welcomeLabel: UILabel = {
        let l: UILabel = .init()
        l.text = "Добро пожаловать в \n MotoCom"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 24, weight: .medium)
        l.textAlignment = .center
        return l
    }()

    private(set) lazy var loginField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Введите email"
        return t
    }()

    private(set) lazy var passField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Введите пароль"
        return t
    }()

    private(set) lazy var forgotPassButton: UIButton = {
        let b: UIButton = .init()
        let attrString = NSAttributedString(string: "Забыли пароль?",
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
        b.setTitle("Войти", for: .normal)
        return b
    }()

    private(set) lazy var regTextButton: UIButton = {
        let b: UIButton = .init()
        var attrString0 = NSMutableAttributedString(string: "Нет аккаунта? ",
                                            attributes:[
                                                .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: "Зарегистрироваться",
                                            attributes:[
                                                .font: UIFont.systemFont(ofSize: 15),
                                                .foregroundColor: UIColor.systemBlue])
        attrString0.append(attrString1)
        b.setAttributedTitle(attrString0, for: .normal)
        return b
    }()

    private(set) lazy var skipLoginButton: UIButton = {
        let b: UIButton = .init()
        var attrString0 = NSMutableAttributedString(string: "или",
                                            attributes:[
                                                .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: "\n Войти без аккаунта",
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
        fatalError("init(coder:) has not been implemented")
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
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        scrollView.addSubviews(bikeImage, welcomeLabel, loginField,
                               passField, forgotPassButton, enterButton,
                               regTextButton, skipLoginButton)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)

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

        regTextButton.pin
            .above(of: skipLoginButton)
            .marginTop(Constants.regTextButton.marginTop)
            .hCenter()
            .height(Constants.regTextButton.height)

        enterButton.pin
            .above(of: regTextButton)
            .left()
            .right()
            .margin(Constants.loginField.marginTop,
                    Constants.loginField.marginHorizontal,
                    Constants.loginField.marginBottom)
            .height(Constants.loginField.height)

        forgotPassButton.pin
            .above(of: enterButton)
            .marginBottom(Constants.forgotPassButton.marginTop)
            .right(Constants.forgotPassButton.marginRight)
            .width(Constants.forgotPassButton.width)

        passField.pin
            .above(of: forgotPassButton)
            .left()
            .right()
            .margin(Constants.loginField.marginTop,
                    Constants.loginField.marginHorizontal,
                    Constants.loginField.marginBottom)
            .height(Constants.loginField.height)

        loginField.pin
            .above(of: passField)
            .left()
            .right()
            .margin(Constants.loginField.marginTop,
                    Constants.loginField.marginHorizontal,
                    Constants.loginField.marginBottom)
            .height(Constants.loginField.height)

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

    struct loginField {
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
