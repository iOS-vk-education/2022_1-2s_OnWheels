//
//  RegistrationViewController.swift
//  OnWheels
//
//  Created by Илья on 11/4/22.
//  
//

import UIKit

final class RegistrationViewController: UIViewController {
	private let output: RegistrationViewOutput

    private(set) lazy var bikeImage: UIImageView = {
        let image: UIImage = UIImage(named: "RegPic") ?? .init()
        let i: UIImageView = .init(image: image)
        return i
    }()

    private(set) lazy var scrollView: UIScrollView = {
        let s: UIScrollView = .init()
        s.contentSize = .init(width: view.frame.size.width, height: view.frame.size.height * 1.2)
        return s
    }()

    private(set) lazy var createLabel: UILabel = {
        let l: UILabel = .init()
        l.text = "Создайте аккаунт"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 24, weight: .medium)
        l.textAlignment = .center
        return l
    }()

    private(set) lazy var hintLabel: UILabel = {
        let l: UILabel = .init()
        l.text = "Пожалуйста, заполните все поля"
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 14, weight: .light)
        l.textAlignment = .center
        return l
    }()

    private(set) lazy var stackView: UIStackView = {
        let s: UIStackView = .init()
        s.axis = .vertical
        s.spacing = Constants.vStackView.spacing
        s.distribution = .fillEqually
        return s
    }()

    private(set) lazy var nameField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Введите имя"
        return t
    }()

    private(set) lazy var surnameField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Введите фамилию"
        return t
    }()

    private(set) lazy var dateGenderStackView: UIStackView = {
        let s: UIStackView = .init()
        s.axis = .horizontal
        s.spacing = Constants.hStackView.spacing
        s.distribution = .fillProportionally
        return s
    }()

    private(set) lazy var birthdateField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Дата рождения"
        return t
    }()

    private(set) lazy var genderField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Пол"
        return t
    }()

    private(set) lazy var cityField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Введите город проживания"
        return t
    }()

    private(set) lazy var emailField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Введите свой e-mail"
        return t
    }()

    private(set) lazy var passField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Создайте пароль"
        return t
    }()

    private(set) lazy var passConfField: customTextField = {
        let t: customTextField = .init()
        t.placeholder = "Подтвердите пароль"
        return t
    }()

    private(set) lazy var rulesButton: UIButton = {
        let b: UIButton = .init()
        var attrString0 = NSMutableAttributedString(string: "Регистрируясь, я соглашаюсь с",
                                            attributes:[
                                                .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: "\n пользовательским соглашением",
                                            attributes:[
                                                .font: UIFont.systemFont(ofSize: 15),
                                                .foregroundColor: UIColor.systemBlue])
        attrString0.append(attrString1)
        b.setAttributedTitle(attrString0, for: .normal)
        b.titleLabel?.numberOfLines = 0
        b.titleLabel?.textAlignment = .center
        return b
    }()

    private(set) lazy var regButton: UIButton = {
        let b: UIButton = .init(configuration: .filled())
        b.titleLabel?.font = .systemFont(ofSize: 20)
        b.setTitle("Зарегистрироваться", for: .normal)
        return b
    }()

    init(output: RegistrationViewOutput) {
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

        addViews()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        
	}

    private func addViews() {
        scrollView.addSubviews(bikeImage, createLabel, hintLabel, stackView)
        stackView.addArrangedSubviews(nameField, surnameField)
        dateGenderStackView.addArrangedSubviews(birthdateField, genderField)
        stackView.addArrangedSubviews(dateGenderStackView, cityField, emailField,
                                      passField, passConfField, rulesButton, regButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.pin
            .all(view.pin.safeArea)

        bikeImage.pin
            .top()
            .left()
            .right()

        createLabel.pin
            .below(of: bikeImage)
            .hCenter()
            .sizeToFit()

        hintLabel.pin
            .below(of: createLabel)
            .left()
            .marginTop(Constants.hintLabel.marginTop)
            .marginLeft(Constants.hintLabel.marginLeft)
            .sizeToFit()

        stackView.pin
            .below(of: hintLabel)
            .left()
            .right()
            .marginTop(Constants.vStackView.marginTop)
            .marginHorizontal(Constants.vStackView.marginHorizontal)
            .height(
                CGFloat(stackView.arrangedSubviews.count) *
                (Constants.textField.height + Constants.vStackView.spacing) - Constants.vStackView.spacing)

    }
}

extension RegistrationViewController: RegistrationViewInput {
}

private struct Constants {
    struct textField {
        static let height: CGFloat = 42
    }
    struct hintLabel {
        static let marginTop: CGFloat = 7
        static let marginLeft: CGFloat = 43
    }
    struct vStackView {
        static let spacing: CGFloat = 21
        static let marginTop: CGFloat = 13
        static let marginHorizontal: CGFloat = 43
    }
    struct hStackView {
        static let spacing: CGFloat = 14
    }
}
