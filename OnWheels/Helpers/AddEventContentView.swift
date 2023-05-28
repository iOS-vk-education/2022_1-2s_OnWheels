//
//  AddEventContentView.swift
//  OnWheels
//
//  Created by Veronika on 03.04.2023.
//

import UIKit

final class AddEventContentView: UIView {
    typealias CloseClosure = () -> Void
    typealias AddClosure = ([String?], Data?) -> Void
    typealias PickerClosure = () -> ()
    
    private var closeAction: CloseClosure?
    
    private var addAction: AddClosure?
    
    private var photoPickerAction: PickerClosure?
    
    private let mainLabel: UILabel = {
        let main = UILabel()
        main.translatesAutoresizingMaskIntoConstraints = false
        main.textColor = R.color.mainBlue()
        main.textAlignment = .center
        main.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return main
    }()
    
    private let closeButton: UIButton = {
        let close = UIButton()
        close.setImage(R.image.closeButton(), for: .normal)
        close.translatesAutoresizingMaskIntoConstraints = false
        close.tintColor = R.color.mainBlue()
        return close
    }()
    
    private let eventNameTextField: СustomTextField = {
        let event = СustomTextField()
        event.translatesAutoresizingMaskIntoConstraints = false
        return event
    }()
    
    private let dateFromToStackView: UIStackView = {
        let dates = UIStackView()
        dates.translatesAutoresizingMaskIntoConstraints = false
        dates.axis = .horizontal
        dates.distribution = .fillProportionally
        dates.spacing = 12
        return dates
    }()
    
    private let dateFromTextField: СustomTextField = {
        let dateFrom = СustomTextField()
        dateFrom.translatesAutoresizingMaskIntoConstraints = false
        return dateFrom
    }()
    
    private let dateToTextField: СustomTextField = {
        let dateTo = СustomTextField()
        dateTo.translatesAutoresizingMaskIntoConstraints = false
        return dateTo
    }()
    
    private let placeTextField: СustomTextField = {
        let place = СustomTextField()
        place.translatesAutoresizingMaskIntoConstraints = false
        return place
    }()
    
    private let tagsStackView: UIStackView = {
        let tags = UIStackView()
        tags.translatesAutoresizingMaskIntoConstraints = false
        tags.axis = .horizontal
        tags.distribution = .fillProportionally
        tags.spacing = 12
        return tags
    }()
    
    private let firstTag: СustomTextField = {
        let tag = СustomTextField()
        tag.translatesAutoresizingMaskIntoConstraints = false
        return tag
    }()
    
    private let secondTag: СustomTextField = {
        let tag = СustomTextField()
        tag.translatesAutoresizingMaskIntoConstraints = false
        return tag
    }()
    
    private let descriptonTextView: UITextView = {
        let description = UITextView()
        description.translatesAutoresizingMaskIntoConstraints = false
        description.textColor = R.color.textFieldText()
        description.backgroundColor = .secondarySystemBackground
        description.font = .systemFont(ofSize: 13)
        description.layer.borderColor = R.color.textFieldBackground()?.cgColor
        description.layer.borderWidth = 1
        description.layer.cornerRadius = 4
        description.layer.cornerRadius = 4
        description.clipsToBounds = true
        return description
    }()
    
    let raceImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = R.image.addRacePicker()
        image.layer.cornerRadius = 4
        image.layer.borderWidth = 1
        image.layer.borderColor = R.color.mainBlue()?.cgColor
        image.clipsToBounds = true
        return image
    }()
    
    
    private let addButton = MainAppButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        descriptonTextView.delegate = self
        addVeiws()
        setupConstraints()
        setupPlaceholders()
        setupTitleForAddButton()
        addTargets()
        setupDatePicker()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddEventContentView {
    func addVeiws() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mainLabel)
        self.addSubview(closeButton)
        self.addSubview(eventNameTextField)
        self.addSubview(dateFromToStackView)
        dateFromToStackView.addArrangedSubview(dateFromTextField)
        dateFromToStackView.addArrangedSubview(dateToTextField)
        self.addSubview(placeTextField)
        self.addSubview(tagsStackView)
        tagsStackView.addArrangedSubview(firstTag)
        tagsStackView.addArrangedSubview(secondTag)
        self.addSubview(descriptonTextView)
        self.addSubview(addButton)
        self.addSubview(raceImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            
            closeButton.centerYAnchor.constraint(equalTo: mainLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            closeButton.widthAnchor.constraint(equalToConstant: 48),
            closeButton.heightAnchor.constraint(equalToConstant: 48),
            
            eventNameTextField.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24),
            eventNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            eventNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            eventNameTextField.heightAnchor.constraint(equalToConstant: 42),
            
            dateFromToStackView.topAnchor.constraint(equalTo: eventNameTextField.bottomAnchor, constant: 12),
            dateFromToStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            dateFromToStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            dateFromToStackView.heightAnchor.constraint(equalToConstant: 42),
            
            placeTextField.topAnchor.constraint(equalTo: dateFromToStackView.bottomAnchor, constant: 12),
            placeTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            placeTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            placeTextField.heightAnchor.constraint(equalToConstant: 42),
            
            tagsStackView.topAnchor.constraint(equalTo: placeTextField.bottomAnchor, constant: 12),
            tagsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            tagsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            tagsStackView.heightAnchor.constraint(equalToConstant: 42),
            
            descriptonTextView.topAnchor.constraint(equalTo: tagsStackView.bottomAnchor, constant: 12),
            descriptonTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            descriptonTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            descriptonTextView.heightAnchor.constraint(equalToConstant: 100),
            
            raceImageView.topAnchor.constraint(equalTo: descriptonTextView.bottomAnchor, constant: 12),
            raceImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            raceImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            raceImageView.heightAnchor.constraint(equalToConstant: 180),
            
            addButton.topAnchor.constraint(equalTo: raceImageView.bottomAnchor, constant: 12),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            addButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func setupDatePicker() {
        let dateFromPicker = setupDate()
        let dateToPicker = setupDate()
        dateFromPicker.addTarget(self, action: #selector(dateFromChange(datePicker:)),
                                 for: UIControl.Event.valueChanged)
        dateToPicker.addTarget(self, action: #selector(dateToChange(datePicker:)),
                               for: UIControl.Event.valueChanged)
        
        dateFromTextField.setupInputView(with: dateFromPicker)
        dateToTextField.setupInputView(with: dateToPicker)
    }
    
    func setupDate() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        datePicker.center = self.center
        return datePicker
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    @objc
    func dateFromChange(datePicker: UIDatePicker){
        dateFromTextField.setupText(with: formatDate(date: datePicker.date))
    }
    
    @objc
    func dateToChange(datePicker: UIDatePicker) {
        dateToTextField.setupText(with: formatDate(date: datePicker.date))
    }
    
    func setupPlaceholders() {
        mainLabel.text = R.string.localizable.addRace()
        eventNameTextField.setupTextField(with: R.string.localizable.eventName())
        dateFromTextField.setupTextField(with: R.string.localizable.dateFrom())
        dateToTextField.setupTextField(with: R.string.localizable.dateTo())
        placeTextField.setupTextField(with: R.string.localizable.placeOfEvent())
        descriptonTextView.text = R.string.localizable.eventDescription()
        firstTag.setupTextField(with: R.string.localizable.firstTag())
        secondTag.setupTextField(with: R.string.localizable.secondTag())
    }
    
    func setupTitleForAddButton() {
        addButton.setupTitle(with: R.string.localizable.addRace())
    }
    
    func addTargets() {
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        raceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imagePickerTapped)))
        raceImageView.isUserInteractionEnabled = true
    }
    
    func setCloseAction(_ action: @escaping CloseClosure) {
        self.closeAction = action
    }
    
    func setAddAction(_ action: @escaping AddClosure) {
        self.addAction = action
    }
    
    func setPickerAction(_ action: @escaping PickerClosure) {
        self.photoPickerAction = action
    }
    
    @objc
    func closeButtonTapped() {
        closeAction?()
    }
    
    @objc
    func imagePickerTapped() {
        photoPickerAction?()
    }
    
    @objc
    func addButtonTapped() {
        var addRaceInfo: [String?] = ["name","datefrom", "dateto", "place", "description", "tag1", "tag2"]
        addRaceInfo[0] = eventNameTextField.text
        addRaceInfo[1] = dateFromTextField.text
        addRaceInfo[2] = dateToTextField.text
        addRaceInfo[3] = placeTextField.text
        if descriptonTextView.text == "" || descriptonTextView.text == R.string.localizable.eventDescription() {
            addRaceInfo[4] = R.string.localizable.noDescription()
        } else {
            addRaceInfo[4] = descriptonTextView.text
        }
        addRaceInfo[5] = firstTag.text
        addRaceInfo[6] = secondTag.text
        
        let imageData = raceImageView.image?.jpegData(compressionQuality: 0.8)
        addAction?(addRaceInfo, imageData)
    }
    
    func setupActions() {
        let tapToHide = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapToHide)
    }
    
    @objc
    func dismissKeyboard() {
        self.endEditing(true)
    }
}

extension AddEventContentView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == R.color.textFieldText() {
            textView.text = nil
            textView.textColor = R.color.profileCellTextColor()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = R.string.localizable.eventDescription()
            textView.textColor = R.color.textFieldText()
        }
    }
}
