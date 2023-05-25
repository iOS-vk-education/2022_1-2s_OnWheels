//
//  EventsInfoCell.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//

import UIKit
import PinLayout

final class EventsInfoCell: UITableViewCell {
    
    typealias LikeClosure = () -> Void
    typealias DislikeClosure = () -> Void
    
    private var likeAction: LikeClosure?
    private var dislikeAction: DislikeClosure?
    
    var id: Int = 0
    //    Вью летющей ячейки
    private let cellView: UIView = {
        let cell = UIView()
        cell.translatesAutoresizingMaskIntoConstraints = false
        cell.backgroundColor = R.color.cellColor()
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }()
    
    //    Заглавная надпись
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 2
        label.textColor = R.color.mainBlue()
        return label
    }()
    
    //    Надпись времени события
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = R.color.mainOrange()
        label.numberOfLines = 1
        return label
    }()
    
    private let eventInfoStackView: UIStackView = {
        let info = UIStackView()
        info.axis = .horizontal
        info.distribution = .fillProportionally
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    //    private let placeInfoStackVeiw = EventInfoStackView()
    private let likeInfoStackVeiw = EventInfoStackView()
    private let participantsInfoStackView = EventInfoStackView()
    private let viewsInfoStackView = EventInfoStackView()
    
    private let eventImageView: KingfisherImage = {
        let imageView = KingfisherImage(placeHolderType: .event)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let tags: [String] = [R.string.localizable.firstTag(), R.string.localizable.secondTag()]
    var isTagsAlreadyDone = false
    var isEventLiked = false
    
    var tagViews: [EventTagView] = []
    
    let tagsStackVeiw: UIStackView = {
        let tags = UIStackView()
        tags.translatesAutoresizingMaskIntoConstraints = false
        tags.axis = .horizontal
        tags.distribution = .fillProportionally
        return tags
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.background()
        setupCell()
        if !isTagsAlreadyDone {
            addTags(with: tags)
            isTagsAlreadyDone = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainLabel.text = ""
        dateLabel.text = ""
        participantsInfoStackView.configureForParticipants(numberOfParticipants: 0)
        viewsInfoStackView.configureForWatchers(numberOfWatchers: 0)
        likeInfoStackVeiw.configureForLikes(isLiked: false, numberOfLikes: 0)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}

private extension EventsInfoCell {
    private func setupCell(){
        self.contentView.addSubview(cellView)
        
        cellView.addSubview(mainLabel)
        
        cellView.addSubview(dateLabel)
        
        cellView.addSubview(tagsStackVeiw)
        
        cellView.addSubview(eventImageView)
        
        cellView.addSubview(eventInfoStackView)
        
        eventInfoStackView.addArrangedSubview(likeInfoStackVeiw)
        eventInfoStackView.addArrangedSubview(participantsInfoStackView)
        eventInfoStackView.addArrangedSubview(viewsInfoStackView)
        
        likeInfoStackVeiw.translatesAutoresizingMaskIntoConstraints = false
        participantsInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        viewsInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        
        setupLayout()
        setupLikeStackView()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 400),
            
            mainLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 6),
            mainLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24),
            mainLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24),
            mainLabel.heightAnchor.constraint(equalToConstant: 44),
            
            dateLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 6),
            dateLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24),
            dateLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24),
            dateLabel.heightAnchor.constraint(equalToConstant: 22),
            
            tagsStackVeiw.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            tagsStackVeiw.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24),
            tagsStackVeiw.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24),
            tagsStackVeiw.heightAnchor.constraint(equalToConstant: 20),
            
            eventImageView.topAnchor.constraint(equalTo: tagsStackVeiw.bottomAnchor, constant: 12),
            eventImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 12),
            eventImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -12),
            eventImageView.heightAnchor.constraint(equalToConstant: 240),
            
            eventInfoStackView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 6),
            eventInfoStackView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 24),
            eventInfoStackView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -24),
            eventInfoStackView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func setupLikeStackView(){
        likeInfoStackVeiw.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(setState)))
    }
    
    @objc
    func setState() {
        if !isEventLiked {
            likeAction?()
        } else {
            dislikeAction?()
        }
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

extension EventsInfoCell {
    func configure(mainText: String,
                   dateText: String,
                   imageName: String,
                   likesNumber: Int,
                   participantsNumber: Int,
                   viewsNumber: Int,
                   isLiked: Bool,
                   tags: [String]) {
        let image = UIImage(named: imageName)
        mainLabel.text = mainText
        dateLabel.text = dateText
        //        placeInfoStackVeiw.configureStackVeiw(image: R.image.location.name,
        //                                              text: placeText)
        
        likeInfoStackVeiw.configureForLikes(isLiked: isLiked, numberOfLikes: likesNumber)
        participantsInfoStackView.configureForParticipants(numberOfParticipants: participantsNumber)
        viewsInfoStackView.configureForWatchers(numberOfWatchers: viewsNumber)
        eventImageView.setImage(url: URL(string: imageName))
        isEventLiked = isLiked
        
        for index in 0...tagViews.count - 1 {
            tagViews[index].configureTag(with: tags[index])
        }
    }
    
    func setLikeAction(_ action: @escaping LikeClosure) {
        self.likeAction = action
    }
    
    func setDislikeAction(_ action: @escaping DislikeClosure) {
        self.dislikeAction = action
    }
}
