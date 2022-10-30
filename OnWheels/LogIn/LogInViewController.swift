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

    private(set) lazy var bikeImage: UIImageView = {
        let image: UIImage = UIImage(named: "loginPic") ?? .init()
        let i: UIImageView = .init(image: image)
        return i
    }()

    private(set) lazy var scrollView: UIScrollView = {
        let s: UIScrollView = .init()
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

    private(set) lazy var loginField: UITextField = {
        let t: UITextField = .init()
        t.placeholder = "Введите номер телефона или почту"
        t.borderStyle = .roundedRect
        t.backgroundColor = .secondarySystemBackground
        t.font = .systemFont(ofSize: 13)
        t.layer.borderColor = UIColor.systemGray3.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 4
        return t
    }()

    private(set) lazy var passField: UITextField = {
        let t: UITextField = .init()
        t.placeholder = "Введите пароль"
        t.borderStyle = .roundedRect
        t.backgroundColor = .secondarySystemBackground
        t.font = .systemFont(ofSize: 13)
        t.layer.borderColor = UIColor.systemGray3.cgColor
        t.layer.borderWidth = 1
        t.layer.cornerRadius = 4
        t.textAlignment = .justified
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

	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(scrollView)
        [bikeImage, welcomeLabel, loginField,
         passField, forgotPassButton, enterButton,
         regTextButton, skipLoginButton].forEach { sub in
            scrollView.addSubview(sub)
        }
	}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.pin
            .all(view.pin.safeArea)

        bikeImage.pin
            .top()
            .left()
            .right()

        welcomeLabel.pin
            .below(of: bikeImage)
            .marginTop(-40)
            .hCenter()
            .sizeToFit()

        loginField.pin
            .below(of: welcomeLabel)
            .left()
            .right()
            .margin(21, 43, 0)
            .height(42)

        passField.pin
            .below(of: loginField)
            .left()
            .right()
            .margin(21, 43, 0)
            .height(of: loginField)

        forgotPassButton.pin
            .below(of: passField)
            .marginTop(21)
            .right(43)
            .width(105)

        enterButton.pin
            .below(of: forgotPassButton)
            .left()
            .right()
            .margin(21, 43, 0)
            .height(of: loginField)

        regTextButton.pin
            .below(of: enterButton)
            .marginTop(16)
            .hCenter()
            .height(18)

        skipLoginButton.pin
            .below(of: regTextButton)
            .marginTop(0)
            .hCenter()
            .height(36)
    }
}

extension LogInViewController: LogInViewInput {
}
