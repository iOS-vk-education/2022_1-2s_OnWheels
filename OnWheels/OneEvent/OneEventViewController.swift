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
    
    let tags: [String] = ["first", "second", "third"]
    var isTagsAlreadyDone = false
    
    private let eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = R.image.oneEventImage()
        return image
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
}

extension OneEventViewController: OneEventViewInput {
    func setupLayout(){
        view.addSubview(eventImage)
        eventImage.pin
            .top()
            .height(Constants.EventImage.height)
            .left()
            .right()
        
        view.addSubview(tagsStackVeiw)
        tagsStackVeiw.pin
            .top(to: eventImage.edge.bottom)
            .marginTop(Constants.TagsStackVeiw.marginTop)
            .left(Constants.TagsStackVeiw.marginLeft)
            .right(Constants.TagsStackVeiw.marginRight)
            .height(Constants.TagsStackVeiw.height)
        
        view.addSubview(eventNameLabel)
        eventNameLabel.pin
            .top(to: tagsStackVeiw.edge.bottom)
            .marginTop(Constants.EventNameLabel.marginTop)
            .left()
            .marginLeft(Constants.EventNameLabel.marginLeft)
            .right()
            .marginRight(Constants.EventNameLabel.marginRight)
            .sizeToFit(.width)
        
        view.addSubview(placeDateInfoStackVeiw)
        placeDateInfoStackVeiw.pin
            .top(to: eventNameLabel.edge.bottom)
            .marginTop(Constants.PlaceDateInfoStackView.marginTop)
            .left(Constants.PlaceDateInfoStackView.marginLeft)
            .height(Constants.PlaceDateInfoStackView.height)
            .width(Constants.PlaceDateInfoStackView.width)
        
        placeDateInfoStackVeiw.addArrangedSubview(placeLabel)
        placeDateInfoStackVeiw.addArrangedSubview(spacingLabel)
        placeDateInfoStackVeiw.addArrangedSubview(dateLabel)
        
        view.addSubview(eventDescriptionLabel)
        eventDescriptionLabel.pin
            .top(to: placeDateInfoStackVeiw.edge.bottom)
            .marginTop(Constants.EventDescriptionLabel.marginTop)
            .left(Constants.EventDescriptionLabel.marginLeft)
            .right(Constants.EventDescriptionLabel.marginRight)
            .sizeToFit(.width)
    }
    
    struct Constants {
        struct EventImage {
            static let height: Percent = 35%
        }
        struct TagsStackVeiw {
            static let height: CGFloat = 20
            static let marginTop: CGFloat = 16
            static let marginLeft: CGFloat = 20
            static let marginRight: CGFloat = 20
        }
        struct EventNameLabel {
            static let marginTop: CGFloat = 16
            static let marginLeft: CGFloat = 20
            static let marginRight: CGFloat = 20
        }
        struct PlaceDateInfoStackView {
            static let marginTop: CGFloat = 12
            static let marginLeft: CGFloat = 20
            static let height: CGFloat = 20
            static let width: Percent = 75%
        }
        struct EventDescriptionLabel {
            static let marginLeft: CGFloat = 20
            static let marginRight: CGFloat = 20
            static let marginTop: CGFloat = 12
        }
    }
}
