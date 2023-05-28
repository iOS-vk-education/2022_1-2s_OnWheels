//
//  RegistrationContentView.swift
//  OnWheels
//
//  Created by Veronika on 18.12.2022.
//

import UIKit
final class RegistrationContentView: UIView {
    typealias RegisterClosure = ([String?]) -> Void
    
    private var registerAction: RegisterClosure?
    
    private let placeholders: [String] = [R.string.localizable.enterName(),
                                          R.string.localizable.enterSurname(),
                                          R.string.localizable.birthdate(),
                                          R.string.localizable.sex(),
                                          R.string.localizable.enterCity(),
                                          R.string.localizable.enterEmail(),
                                          R.string.localizable.enterPassword(),
                                          R.string.localizable.confirmPassword()]
    private let genderData = [R.string.localizable.man(), R.string.localizable.woman()]
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let image = R.image.regPic() ?? .init()
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
    
    let bikeImage: UIImageView = {
        let bike = UIImageView()
        bike.translatesAutoresizingMaskIntoConstraints = false
        bike.image = R.image.regPic()
        //        if traitCollection.userInterfaceStyle == .dark {
        //            let startImage = CIImage(image: bike)
        //            let filter = CIFilter(name: "CIColorInvert")
        //            filter?.setValue(startImage, forKey: kCIInputImageKey)
        //            let newImage = UIImage(ciImage: filter?.outputImage ?? .empty())
        //            bike.image = newImage
        //        }
        bike.contentMode = .scaleAspectFit
        return bike
    }()
    
    private let createLabel: UILabel = {
        let create = UILabel()
        create.translatesAutoresizingMaskIntoConstraints = false
        create.text = R.string.localizable.createAccount()
        create.font = .systemFont(ofSize: 24, weight: .medium)
        create.textAlignment = .center
        return create
    }()
    
    private let hintLabel: UILabel = {
        let hint = UILabel()
        hint.translatesAutoresizingMaskIntoConstraints = false
        hint.text = R.string.localizable.fillFields()
        hint.font = .systemFont(ofSize: 14, weight: .light)
        hint.textAlignment = .center
        return hint
    }()
    
    private(set) lazy var textFields: [CustomTextField] = {
        var textFields = [CustomTextField]()
        for value in 0..<8 {
            let text = CustomTextField()
            text.translatesAutoresizingMaskIntoConstraints = false
            text.tag = value + 1
            text.autocorrectionType = .no
            textFields.append(text)
        }
        return textFields
    }()
    
    private let birthdayGenderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 14
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let rulesLabel: UILabel = {
        let rules = UILabel()
        rules.translatesAutoresizingMaskIntoConstraints = false
        var attrString0 = NSMutableAttributedString(string: R.string.localizable.acceptRules(),
                                                    attributes:[
                                                        .font: UIFont.systemFont(ofSize: 15)])
        let attrString1 = NSAttributedString(string: R.string.localizable.acceptRules2(),
                                             attributes:[
                                                .font: UIFont.systemFont(ofSize: 15),
                                                .foregroundColor: UIColor.systemBlue])
        attrString0.append(attrString1)
        rules.attributedText = attrString0
        rules.numberOfLines = 0
        rules.textAlignment = .center
        return rules
    }()
    
    let registrationButton: MainAppButton = {
        let registration = MainAppButton()
        registration.translatesAutoresizingMaskIntoConstraints = false
        return registration
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupConstraints()
        setupTextFields()
        setupGenderField()
        setupDatePicker()
        setupRegistrationButton()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

extension RegistrationContentView {
    func setupConstraints(){
        self.addSubview(bikeImage)
        self.addSubview(createLabel)
        self.addSubview(hintLabel)
        NSLayoutConstraint.activate([
            bikeImage.topAnchor.constraint(equalTo: self.topAnchor),
            bikeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bikeImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            createLabel.topAnchor.constraint(equalTo: bikeImage.bottomAnchor),
            createLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hintLabel.topAnchor.constraint(equalTo: createLabel.bottomAnchor, constant: 7),
            hintLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43)
        ])
        
        self.addSubview(birthdayGenderStackView)
        
        if let firstView = textFields.first, textFields.count > 1 {
            self.addSubview(firstView)
            NSLayoutConstraint.activate([
                firstView.topAnchor.constraint(equalTo: hintLabel.bottomAnchor, constant: 11),
                firstView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43),
                firstView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -43),
                firstView.heightAnchor.constraint(equalToConstant: 42)
            ])
            
            for value in 1..<8 {
                if value == 2 || value == 3 {
                    birthdayGenderStackView.addArrangedSubview(textFields[value])
                    NSLayoutConstraint.activate([
                        birthdayGenderStackView.topAnchor.constraint(equalTo: textFields[1].bottomAnchor, constant: 11),
                        birthdayGenderStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43),
                        birthdayGenderStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                                          constant: -43),
                        birthdayGenderStackView.heightAnchor.constraint(equalToConstant: 42)
                    ])
                } else {
                    self.addSubview(textFields[value])
                    NSLayoutConstraint.activate([
                        textFields[value].topAnchor.constraint(equalTo: textFields[value - 1].bottomAnchor,
                                                               constant: 11),
                        textFields[value].leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43),
                        textFields[value].trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -43),
                        textFields[value].heightAnchor.constraint(equalToConstant: 42)
                    ])
                }
                
            }
        }
        
        self.addSubview(rulesLabel)
        guard let lastView = textFields.last else {
            return
        }
        NSLayoutConstraint.activate([
            rulesLabel.topAnchor.constraint(equalTo: lastView.bottomAnchor, constant: 11),
            rulesLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            rulesLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        self.addSubview(registrationButton)
        NSLayoutConstraint.activate([
            registrationButton.topAnchor.constraint(equalTo: rulesLabel.bottomAnchor, constant: 11),
            registrationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 43),
            registrationButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -43),
            registrationButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func setupRegistrationButton() {
        registrationButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        registrationButton.setupTitle(with: R.string.localizable.register())
    }
    
    func setupTextFields(){
        for value in 0..<8{
            textFields[value].setupTextField(with: placeholders[value])
        }
        textFields[6].isSecureTextEntry = true
        textFields[7].isSecureTextEntry = true
    }
    
    func setupGenderField() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        genderPicker.frame = .init(x: 0, y: 0, width: 300, height: 300)
        textFields[3].inputView = genderPicker
    }
    
    func setupDatePicker() {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)),
                             for: UIControl.Event.valueChanged)
        datePicker.frame = .init(x: 0, y: 0, width: 300, height: 342)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        datePicker.center = self.center
        textFields[2].inputView = datePicker
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    @objc
    func dateChange(datePicker: UIDatePicker){
        textFields[2].text = formatDate(date: datePicker.date)
    }
    
    func setRegisterAction(_ action: @escaping RegisterClosure) {
        self.registerAction = action
    }
}

private extension RegistrationContentView {
    @objc
    func registerButtonTapped() {
        let registerInfo = textFields.map { tf in
            return tf.text
        }
        registerAction?(registerInfo)
    }
}

extension RegistrationContentView: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genderData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = genderData[row]
        textFields[3].text = row
        return row
    }
}
