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
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let image: UIImage = UIImage(named: R.image.regPic.name) ?? .init()
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
    
    private let backButton: UIButton = {
        let back = UIButton()
        back.setImage(R.image.backButton(), for: .normal)
        back.tintColor = R.color.mainBlue()
        return back
    }()
    
    private(set) lazy var bikeImage: UIImageView = {
        let image: UIImage = UIImage(named: R.image.regPic.name) ?? .init()
        var i: UIImageView = .init(image: image)
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
        return s
    }()
    
    private(set) lazy var createLabel: UILabel = {
        let l: UILabel = .init()
        l.text = R.string.localizable.createAccount()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 24, weight: .medium)
        l.textAlignment = .center
        return l
    }()
    
    private(set) lazy var hintLabel: UILabel = {
        let l: UILabel = .init()
        l.text = R.string.localizable.fillFields()
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
    
    private(set) lazy var nameField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterName()
        return t
    }()
    
    private(set) lazy var surnameField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterSurname()
        return t
    }()
    
    private(set) lazy var dateGenderStackView: UIStackView = {
        let s: UIStackView = .init()
        s.axis = .horizontal
        s.spacing = Constants.hStackView.spacing
        s.distribution = .fillProportionally
        return s
    }()
    
    private(set) lazy var birthdateField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.birthdate()
        return t
    }()
    
    private(set) lazy var genderField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.sex()
        return t
    }()
    
    private(set) lazy var cityField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterCity()
        return t
    }()
    
    private(set) lazy var emailField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.enterEmail()
        return t
    }()
    
    private(set) lazy var passField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.createPassword()
        return t
    }()
    
    private(set) lazy var passConfField: СustomTextField = {
        let t: СustomTextField = .init()
        t.placeholder = R.string.localizable.confirmPassword()
        return t
    }()
    
    private(set) lazy var rulesButton: UIButton = {
        let b: UIButton = .init()
        var attrString0 = NSMutableAttributedString(string: R.string.localizable.acceptRules(),
                                                    attributes:[
                                                        .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: R.string.localizable.acceptRules2(),
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
        b.setTitle(R.string.localizable.register(), for: .normal)
        return b
    }()
    
    init(output: RegistrationViewOutput) {
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
            scrollView.contentOffset.y += keyboardHeight
        }
    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
                               as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            scrollView.contentOffset.y -= keyboardHeight
        }
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func backButtonTapped(){
        UIView.animate(withDuration: 0.2){ [weak self] in
            self?.backButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.backButtonAction()
                self?.backButton.alpha = 1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        
        addViews()
        setupBindings()
        setupNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setupBindings() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapToHide)
        regButton.addTarget(self, action: #selector(didTapRegButton), for: .touchUpInside)
    }
    
    func setupNavBar (){
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftNavBarItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButton(leftNavBarItem, animated: true)
    }
    
    private func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame = .init(x: 0, y: 0, width: 300, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        datePicker.center = view.center
        birthdateField.inputView = datePicker
        birthdateField.text = formatDate(date: Date()) // todays Date
    }
    
    @objc
    func dateChange(datePicker: UIDatePicker){
        birthdateField.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
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
            .height(view.frame.height / 2)
        
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
        
        scrollView.contentSize = .init(width: view.frame.size.width,
                                       height: stackView.frame.height + bikeImage.frame.height + 100)
        
        
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
}

extension RegistrationViewController: RegistrationViewInput {
}
