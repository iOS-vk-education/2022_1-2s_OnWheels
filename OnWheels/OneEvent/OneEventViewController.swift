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
    
    private let eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = R.image.oneEventImage()
        return image
    }()
    
    let tagsStackVeiw: UIStackView = {
        let tags = UIStackView()
        tags.spacing = 120
        tags.alignment = .center
        tags.axis = .horizontal
        return tags
    }()
    
    init(output: OneEventViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
        view.backgroundColor = R.color.background()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    func addTags(with tags: [String]) {
        tags.forEach { text in
            let tag = EventTagView()
            tag.configureTag(with: text)
            
            tag.layer.cornerRadius = 8
            tag.clipsToBounds = true
            
            tagsStackVeiw.addArrangedSubview(tag)
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
            .right()
            .height(Constants.TagsStackVeiw.height)
        
        addTags(with: tags)
    }
    
    struct Constants {
        struct EventImage {
            static let height: Percent = 35%
        }
        struct TagsStackVeiw {
            static let height: CGFloat = 20
            static let marginTop: CGFloat = 20
            static let marginLeft: CGFloat = 20
        }
    }
}
