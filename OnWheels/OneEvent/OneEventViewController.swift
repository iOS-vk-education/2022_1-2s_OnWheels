//
//  OneEventViewController.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import UIKit
import PinLayout
import CoreLocation

final class OneEventViewController: UIViewController, UIGestureRecognizerDelegate {
    private let output: OneEventViewOutput
    
    private let eventScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let eventContentView = UIView()
    
    let tags: [String] = [R.string.localizable.firstTag(), R.string.localizable.secondTag()]
    var isTagsAlreadyDone = false
    
    private let eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        image.image = R.image.oneEventImage()
        return image
    }()
    
    private let backButton: UIButton = {
        let back = UIButton()
        back.translatesAutoresizingMaskIntoConstraints = false
        back.setImage(R.image.backButton(), for: .normal)
        back.tintColor = R.color.mainBlue()
        return back
    }()
    
    let tagsStackVeiw: UIStackView = {
        let tags = UIStackView()
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
    
    init(output: OneEventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.background()
        setupGestureRecognizer()
        output.loadInfo()
        setupLayout()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !isTagsAlreadyDone {
            addTags(with: tags)
            isTagsAlreadyDone = true
        }
        let widthFrame = eventContentView.frame.width
        let height = eventContentView.bounds.height + 100
        eventScrollView.contentSize = CGSize(width: widthFrame,
                                             height: height)
    }
    
    func configureViewWith(name: String, description: String, place: String, date: String) {
        eventNameLabel.text = name
        dateLabel.text = date
        placeLabel.text = place
        eventDescriptionLabel.text = description
    }
    
    func addTags(with tags: [String]) {
        tags.forEach { text in
            let tag = EventTagView()
            tag.configureTag(with: text)
            
            tag.layer.cornerRadius = 8
            
            tagsStackVeiw.addArrangedSubview(tag)
            tag.pin
                .top(to: tagsStackVeiw.edge.top)
                .bottom(to: tagsStackVeiw.edge.bottom)
            
            tagsStackVeiw.setCustomSpacing(24 + tag.frame.width , after: tag)
        }
    }
    
    @objc
    func backButtonTapped(){
        output.backButtonTapped()
    }
    
    @objc
    func swipeAction(swipe: UISwipeGestureRecognizer) {
        output.backButtonTapped()
    }
}

extension OneEventViewController {
    private func setupLayout(){
        view.addSubview(eventImage)
        NSLayoutConstraint.activate([
            eventImage.topAnchor.constraint(equalTo: view.topAnchor),
            eventImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        eventContentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(eventScrollView)
        NSLayoutConstraint.activate([
            eventScrollView.topAnchor.constraint(equalTo: eventImage.bottomAnchor),
            eventScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eventScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eventScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        eventScrollView.addSubview(eventContentView)
        NSLayoutConstraint.activate([
            eventContentView.topAnchor.constraint(equalTo: eventScrollView.topAnchor, constant: 16),
            eventContentView.leadingAnchor.constraint(equalTo: eventScrollView.leadingAnchor, constant: 20),
            eventScrollView.trailingAnchor.constraint(equalTo: eventScrollView.trailingAnchor, constant: -20),
            eventContentView.bottomAnchor.constraint(equalTo: eventScrollView.bottomAnchor),
            eventContentView.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])
        
        eventContentView.addSubview(eventNameLabel)
        NSLayoutConstraint.activate([
            eventNameLabel.topAnchor.constraint(equalTo: eventContentView.topAnchor),
            eventNameLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor),
            eventNameLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor)
        ])

        eventContentView.addSubview(placeDateInfoStackVeiw)
        NSLayoutConstraint.activate([
            placeDateInfoStackVeiw.topAnchor.constraint(equalTo: eventNameLabel.bottomAnchor, constant: 12),
            placeDateInfoStackVeiw.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor),
            placeDateInfoStackVeiw.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor)
        ])

        placeDateInfoStackVeiw.addArrangedSubview(placeLabel)
        placeDateInfoStackVeiw.addArrangedSubview(spacingLabel)
        placeDateInfoStackVeiw.addArrangedSubview(dateLabel)
        
        eventContentView.addSubview(eventDescriptionLabel)
        NSLayoutConstraint.activate([
            eventDescriptionLabel.topAnchor.constraint(equalTo: placeDateInfoStackVeiw.bottomAnchor, constant: 12),
            eventDescriptionLabel.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor),
            eventDescriptionLabel.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor)
        ])
        
        eventContentView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: eventDescriptionLabel.bottomAnchor, constant: 12),
            mapView.leadingAnchor.constraint(equalTo: eventContentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: eventContentView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 240)
        ])
        
        setupNavBar()
    }
    
    private func setupNavBar (){
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftNavBarItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButton(leftNavBarItem, animated: true)
    }
    
    private func setupGestureRecognizer(){
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}

extension OneEventViewController: OneEventViewInput {
    func setData(raceData: OneRace){
        print(raceData)
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter1.locale = Locale(identifier: "en_US_POSIX")
        var dateString = ""
          
        if let date2 = formatter1.date(from: raceData.date.from) {
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "EEEE, MMM d, yyyy"
            formatter2.locale = Locale(identifier: "en_US_POSIX")

            dateString = formatter2.string(from: date2)
        }
        
        let location = CLLocation(latitude: raceData.location.latitude, longitude: raceData.location.longitude)
        
        var cityLoc = ""
        var countryLoc = ""
        
        location.fetchCityAndCountry { [weak self] city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            cityLoc = city // Rio de Janeiro, Brazil
            DispatchQueue.main.async {
                self?.configureViewWith(name: raceData.name,
                                  description: raceData.oneRaceDescription,
                                  place: cityLoc, date: dateString)
                self?.mapView.cofigureMap(latitude: raceData.location.latitude, longitude: raceData.location.longitude, name: cityLoc)
            }
        }
    }
}
