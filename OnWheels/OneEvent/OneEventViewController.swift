//
//  OneEventViewController.swift
//  OnWheels
//
//  Created by Veronika on 21.11.2022.
//  
//

import UIKit
import PinLayout

final class OneEventViewController: UIViewController {
    private let output: OneEventViewOutput
    
    private let eventScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let eventContentView = UIView()
    
    let tags: [String] = [R.string.localizable.firstTag(), R.string.localizable.secondTag()]
    var isTagsAlreadyDone = false
    
    private let eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = R.image.oneEventImage()
        return image
    }()
    
    private let backButton: UIButton = {
        let back = UIButton()
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
        eventName.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        eventName.numberOfLines = 0
        eventName.textAlignment = .left
        eventName.text = R.string.localizable.eventName()
        return eventName
    }()
    
    let placeDateInfoStackVeiw: UIStackView = {
        let placeDateInfo = UIStackView()
        placeDateInfo.axis = .horizontal
        placeDateInfo.spacing = 10
        return placeDateInfo
    }()
    
    let placeLabel: UILabel = {
        let place = UILabel()
        place.textAlignment = .left
        place.textColor = R.color.mainOrange()
        place.text = R.string.localizable.eventPlace()
        place.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return place
    }()
    
    let spacingLabel: UILabel = {
        let spacing = UILabel()
        spacing.text = "|"
        spacing.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        spacing.textColor = .secondaryLabel
        return spacing
    }()
    
    let dateLabel: UILabel = {
        let date = UILabel()
        date.text = R.string.localizable.eventDate()
        date.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        date.textColor = .secondaryLabel
        return date
    }()
    
    let eventDescriptionLabel: UILabel = {
        let eventDescription = UILabel()
        eventDescription.textColor = R.color.profileCellTextColor()
        eventDescription.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        eventDescription.numberOfLines = 0
        eventDescription.textAlignment = .left
        eventDescription.text = R.string.localizable.eventDescription()
        return eventDescription
    }()
    
    let mapView: EventMapView = {
        let map = EventMapView()
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
        if !isTagsAlreadyDone {
            addTags(with: tags)
            isTagsAlreadyDone = true
        }
        
        let heightFrame = eventContentView.frame.height
        let widthFrame = eventContentView.frame.width
        eventScrollView.contentSize = CGSize(width: widthFrame, height: heightFrame)
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
}

extension OneEventViewController: OneEventViewInput {
    func setupLayout(){
        view.addSubview(eventImage)
        eventImage.pin
            .top()
            .height(Constants.EventImage.height)
            .left()
            .right()
        
        view.addSubview(eventScrollView)
        eventScrollView.pin
            .top(to: eventImage.edge.bottom)
            .left()
            .right()
            .bottom()
        
        eventScrollView.addSubview(eventContentView)
        eventContentView.pin
            .top(Constants.EventContentView.marginTop)
            .left(Constants.EventContentView.marginLeft)
            .right(Constants.EventContentView.marginRight)
            .bottom(to: eventScrollView.edge.bottom)
            .height(view.frame.height * 0.7)
        
        eventContentView.addSubview(tagsStackVeiw)
        tagsStackVeiw.pin
            .top(to: eventContentView.edge.top)
            .left()
            .right()
            .height(Constants.TagsStackVeiw.height)
        
        eventContentView.addSubview(eventNameLabel)
        eventNameLabel.pin
            .top(to: tagsStackVeiw.edge.bottom)
            .marginTop(Constants.EventNameLabel.marginTop)
            .left()
            .right()
            .sizeToFit(.width)
        
        eventContentView.addSubview(placeDateInfoStackVeiw)
        placeDateInfoStackVeiw.pin
            .top(to: eventNameLabel.edge.bottom)
            .marginTop(Constants.PlaceDateInfoStackView.marginTop)
            .left()
            .height(Constants.PlaceDateInfoStackView.height)
            .width(Constants.PlaceDateInfoStackView.width)
        
        placeDateInfoStackVeiw.addArrangedSubview(placeLabel)
        placeDateInfoStackVeiw.addArrangedSubview(spacingLabel)
        placeDateInfoStackVeiw.addArrangedSubview(dateLabel)
        
        eventContentView.addSubview(eventDescriptionLabel)
        eventDescriptionLabel.pin
            .top(to: placeDateInfoStackVeiw.edge.bottom)
            .marginTop(Constants.EventDescriptionLabel.marginTop)
            .left()
            .right()
            .sizeToFit(.width)
        
        eventContentView.addSubview(mapView)
        mapView.pin
            .top(to: eventDescriptionLabel.edge.bottom)
            .marginTop(Constants.MapView.marginTop)
            .left()
            .right()
            .height(Constants.MapView.height)
        
        setupNavBar()
    }
    
    func setupNavBar (){
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftNavBarItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.setLeftBarButton(leftNavBarItem, animated: true)
    }
    
    struct Constants {
        
        struct EventImage {
            static let height: Percent = 35%
        }
        struct EventContentView {
            static let marginTop: CGFloat = 16
            static let marginLeft: CGFloat = 20
            static let marginRight: CGFloat = 20
        }
        
        struct TagsStackVeiw {
            static let height: CGFloat = 20
        }
        
        struct EventNameLabel {
            static let marginTop: CGFloat = 16
        }
        
        struct PlaceDateInfoStackView {
            static let marginTop: CGFloat = 12
            static let height: CGFloat = 20
            static let width: Percent = 80%
        }
        
        struct EventDescriptionLabel {
            static let marginTop: CGFloat = 12
        }
        
        struct MapView {
            static let marginTop: CGFloat = 20
            static let height: CGFloat = 240
        }
    }
}
