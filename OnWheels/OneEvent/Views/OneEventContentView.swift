//
//  OneEventContentView.swift
//  OnWheels
//
//  Created by Veronika on 26.05.2023.
//

import UIKit

final class OneEventContentView: UIView {
    typealias ParticipateAction = () -> ()
    
    private var setParticipationAction: ParticipateAction?
    private var unsetParticipationAction: ParticipateAction?
    
    private var isUserMember: Bool = false
    
    
    var tagViews: [EventTagView] = []
    var isTagsAlreadyDone = false
    
    private let eventImage: KingfisherImage = {
        let image = KingfisherImage(placeHolderType: .event)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    let tagsStackVeiw: UIStackView = {
        let tags = UIStackView()
        tags.translatesAutoresizingMaskIntoConstraints = false
        tags.axis = .horizontal
        tags.distribution = .fillProportionally
        return tags
    }()
    
    let eventNameLabel: UILabel = {
        let eventName = UILabel()
        eventName.textColor = R.color.mainBlue()
        eventName.translatesAutoresizingMaskIntoConstraints = false
        eventName.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        eventName.numberOfLines = 0
        eventName.textAlignment = .left
        eventName.text = R.string.localizable.eventName()
        return eventName
    }()
    
    let placeDateInfoStackVeiw: UIStackView = {
        let placeDateInfo = UIStackView()
        placeDateInfo.translatesAutoresizingMaskIntoConstraints = false
        placeDateInfo.axis = .horizontal
        placeDateInfo.spacing = 10
        return placeDateInfo
    }()
    
    let placeLabel: UILabel = {
        let place = UILabel()
        place.translatesAutoresizingMaskIntoConstraints = false
        place.textAlignment = .left
        place.textColor = R.color.mainOrange()
        place.text = R.string.localizable.eventPlace()
        place.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return place
    }()
    
    let spacingLabel: UILabel = {
        let spacing = UILabel()
        spacing.translatesAutoresizingMaskIntoConstraints = false
        spacing.text = "|"
        spacing.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        spacing.textColor = .secondaryLabel
        return spacing
    }()
    
    let dateLabel: UILabel = {
        let date = UILabel()
        date.translatesAutoresizingMaskIntoConstraints = false
        date.text = R.string.localizable.eventDate()
        date.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        date.textColor = .secondaryLabel
        return date
    }()
    
    let eventDescriptionLabel: UILabel = {
        let eventDescription = UILabel()
        eventDescription.translatesAutoresizingMaskIntoConstraints = false
        eventDescription.textColor = R.color.profileCellTextColor()
        eventDescription.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        eventDescription.numberOfLines = 0
        eventDescription.textAlignment = .left
        eventDescription.text = R.string.localizable.eventDescription()
        return eventDescription
    }()
    
    let mapView: EventMapView = {
        let map = EventMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 16
        map.clipsToBounds = true
        return map
    }()
    
    let participateButton: MainAppButton = {
        let button = MainAppButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var realHeight: CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        realHeight = eventImage.frame.size.height
        realHeight = realHeight + eventNameLabel.frame.size.height
        realHeight = realHeight + placeDateInfoStackVeiw.frame.size.height
        realHeight = realHeight + tagsStackVeiw.frame.size.height
        realHeight = realHeight + eventDescriptionLabel.frame.size.height
        realHeight = realHeight + mapView.frame.size.height
        realHeight = realHeight + participateButton.frame.size.height + 110
    }
}

private extension OneEventContentView {
    func addViews() {
        self.addSubview(eventImage)
        self.addSubview(eventNameLabel)
        self.addSubview(placeDateInfoStackVeiw)
        placeDateInfoStackVeiw.addArrangedSubview(placeLabel)
        placeDateInfoStackVeiw.addArrangedSubview(spacingLabel)
        placeDateInfoStackVeiw.addArrangedSubview(dateLabel)
        self.addSubview(tagsStackVeiw)
        self.addSubview(eventDescriptionLabel)
        self.addSubview(mapView)
        self.addSubview(participateButton)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: self.topAnchor),
            eventImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            eventImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            eventImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 12),
            eventNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            eventNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            placeDateInfoStackVeiw.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 12),
            placeDateInfoStackVeiw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            placeDateInfoStackVeiw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            tagsStackVeiw.topAnchor.constraint(equalTo: placeDateInfoStackVeiw.bottomAnchor, constant: 12),
            tagsStackVeiw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            tagsStackVeiw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            tagsStackVeiw.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            eventDescriptionLabel.topAnchor.constraint(equalTo: tagsStackVeiw.bottomAnchor, constant: 12),
            eventDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            eventDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: eventDescriptionLabel.bottomAnchor, constant: 12),
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            mapView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        NSLayoutConstraint.activate([
            participateButton.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 12),
            participateButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            participateButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            participateButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func addTags(with tags: [String]) {
        tags.forEach { text in
            let tag = EventTagView()
            tag.configureTag(with: text)
            
            tag.layer.cornerRadius = 8
            
            tagsStackVeiw.addArrangedSubview(tag)
            
            tag.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                tag.topAnchor.constraint(equalTo: tagsStackVeiw.topAnchor),
                tag.bottomAnchor.constraint(equalTo: tagsStackVeiw.bottomAnchor)
            ])
            
            tagsStackVeiw.setCustomSpacing(24 + tag.frame.width , after: tag)
            
            tagViews.append(tag)
        }
    }
}

extension OneEventContentView {
    func configureViewWith(imageURL: String,
                           mainText: String,
                           placeName: String,
                           dateText: String,
                           additionalText: String,
                           longitude: Double,
                           latitude: Double,
                           tags: [String]) {
        eventImage.setImage(url: URL(string: imageURL))
        eventNameLabel.text = mainText
        placeLabel.text = placeName
        dateLabel.text = dateText
        eventDescriptionLabel.text = additionalText
        mapView.cofigureMap(latitude: latitude, longitude: longitude, name: placeName)
        if !tags.isEmpty {
            if !isTagsAlreadyDone {
                addTags(with: tags)
                isTagsAlreadyDone = true
            }
            
            let range = min(tags.count - 1, tagViews.count - 1)
            
            for index in 0...range {
                tagViews[index].configureTag(with: tags[index])
            }
        }
    }
    
    func configureButton(isMember: Bool) {
        if isMember {
            participateButton.changeButtonColor(with: R.color.mainOrange() ?? .orange)
            participateButton.isHidden = false
            participateButton.setupTitle(with: "Вы записаны")
            isUserMember = isMember
        } else {
            participateButton.setupTitle(with: R.string.localizable.participate())
            participateButton.changeButtonColor(with: R.color.mainBlue() ?? .blue)
            participateButton.isHidden = false
            isUserMember = isMember
        }
    }
    
    func setParticipateAction(_ action: @escaping ParticipateAction) {
        self.setParticipationAction = action
    }
    
    func unsetParticipateAction(_ action: @escaping ParticipateAction) {
        self.unsetParticipationAction = action
    }
    
    func hideButton() {
        participateButton.isHidden = true
    }
}
