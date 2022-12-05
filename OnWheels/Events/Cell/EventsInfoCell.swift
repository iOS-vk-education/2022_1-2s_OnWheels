//
//  EventsInfoCell.swift
//  OnWheels
//
//  Created by Андрей Стрельченко on 10.11.2022.
//

import UIKit
import PinLayout

final class EventsInfoCell: UITableViewCell {
    //    Вью летющей ячейки
    private let cellView: UIView = {
        let cell = UIView()
        cell.backgroundColor = R.color.cellColor()
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }()
    
    //    Заглавная надпись
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textColor = .mainBlueColor
        return label
    }()
    
    //    Надпись времени события
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = R.color.mainOrange()
        return label
    }()
    
    private let placeInfoStackVeiw = EventInfoStackView()
    private let likeInfoStackVeiw = EventInfoStackView()
    private let sharedInfoStackView = EventInfoStackView()
    private let watchedInfoStackView = EventInfoStackView()
    
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.image.eventImageBase()
        return imageView
    }()
    
    let tags: [String] = [R.string.localizable.firstTag(), R.string.localizable.secondTag()]
    var isTagsAlreadyDone = false
    var isEventLiked = false
    
    let tagsStackVeiw: UIStackView = {
        let tags = UIStackView()
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
        placeInfoStackVeiw.infoLabel.text = ""
        sharedInfoStackView.infoLabel.text = ""
        watchedInfoStackView.infoLabel.text = ""
        likeInfoStackVeiw.infoLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupCell(){
        self.contentView.addSubview(cellView)
        
        cellView.addSubview(mainLabel)
        
        cellView.addSubview(dateLabel)
        
        cellView.addSubview(placeInfoStackVeiw)
        
        cellView.addSubview(tagsStackVeiw)
        
        cellView.addSubview(eventImageView)
        
        cellView.addSubview(likeInfoStackVeiw)
        cellView.addSubview(sharedInfoStackView)
        cellView.addSubview(watchedInfoStackView)
        
        setupLayout()
        setupLikeStackView()
    }
    
    func setupLayout() {
        cellView.pin
            .top(Constants.CellView.top)
            .left()
            .right()
            .height(Constants.CellView.height)
            .bottom(Constants.CellView.bottom)
        
        mainLabel.pin
            .top(Constants.MainLabel.top)
            .left(Constants.MainLabel.left)
            .right(Constants.MainLabel.right)
            .height(Constants.MainLabel.height)
        
        dateLabel.pin
            .top(to: mainLabel.edge.bottom)
            .marginTop(Constants.DateLabel.top)
            .left(Constants.DateLabel.left)
            .right(Constants.DateLabel.right)
            .height(Constants.DateLabel.height)
        
        placeInfoStackVeiw.pin
            .top(to: dateLabel.edge.bottom)
            .marginTop(Constants.PlaceInfoStackView.top)
            .left(Constants.PlaceInfoStackView.left)
            .height(Constants.PlaceInfoStackView.height)
            .width(Constants.PlaceInfoStackView.width)
        
        tagsStackVeiw.pin
            .top(to: placeInfoStackVeiw.edge.bottom)
            .marginTop(Constants.TagsStackView.top)
            .left(Constants.TagsStackView.left)
            .right(Constants.TagsStackView.right)
            .height(Constants.TagsStackView.height)
        
        eventImageView.pin
            .top(to: tagsStackVeiw.edge.bottom)
            .marginTop(Constants.EventImageView.top)
            .height(Constants.EventImageView.height)
            .left(Constants.EventImageView.left)
            .right(Constants.EventImageView.right)
        
        likeInfoStackVeiw.pin
            .top(to: eventImageView.edge.bottom)
            .marginTop(Constants.InfoStackVeiws.top)
            .left(Constants.InfoStackVeiws.left)
            .width(Constants.InfoStackVeiws.width)
            .height(Constants.InfoStackVeiws.height)
        
        sharedInfoStackView.pin
            .top(to: eventImageView.edge.bottom)
            .marginTop(Constants.InfoStackVeiws.top)
            .left(to: likeInfoStackVeiw.edge.right)
            .marginLeft(Constants.InfoStackVeiws.left)
            .width(Constants.InfoStackVeiws.width)
            .height(Constants.InfoStackVeiws.height)
        
        watchedInfoStackView.pin
            .top(to: eventImageView.edge.bottom)
            .marginTop(Constants.InfoStackVeiws.top)
            .left(to: sharedInfoStackView.edge.right)
            .marginLeft(Constants.InfoStackVeiws.left)
            .width(Constants.InfoStackVeiws.width)
            .height(Constants.InfoStackVeiws.height)
    }
    
    struct Constants {
        struct CellView {
            static let top: CGFloat = 10
            static let bottom: CGFloat = 10
            static let height: CGFloat = 390
        }
        
        struct MainLabel {
            static let top: CGFloat = 16
            static let left: CGFloat = 24
            static let right: CGFloat = 24
            static let height: CGFloat = 50
        }
        
        struct DateLabel {
            static let top: CGFloat = 5
            static let left: CGFloat = 24
            static let right: CGFloat = 24
            static let height: CGFloat = 14
        }
        
        struct PlaceInfoStackView {
            static let top: CGFloat = 8
            static let left: CGFloat = 24
            static let width: CGFloat = 200
            static let height: CGFloat = 30
        }
        
        struct TagsStackView {
            static let top: CGFloat = 10
            static let left: CGFloat = 24
            static let right: CGFloat = 24
            static let height: CGFloat = 20
        }
        
        struct EventImageView {
            static let top: CGFloat = 12
            static let left: CGFloat = 12
            static let right: CGFloat = 12
            static let height: CGFloat = 180
        }
        
        struct InfoStackVeiws {
            static let top: CGFloat = 10
            static let left: CGFloat = 24
            static let width: CGFloat = 50
            static let height: CGFloat = 24
        }
    }
    
    func setupLikeStackView(){
        likeInfoStackVeiw.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                      action: #selector(setState)))
    }
    
    @objc
    func setState() {
        if !isEventLiked {
            likeInfoStackVeiw.infoImageView.image = R.image.likeTapped()
            isEventLiked = !isEventLiked
        } else {
            likeInfoStackVeiw.infoImageView.image = R.image.likes()
            isEventLiked = !isEventLiked
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
    
    /// заполнение ячейки данными
    /// - Parameters:
    ///   - mainText: Главный текст
    ///   - dateText: Время проведения
    ///   - placeText: Место проведения
    ///   - likeText: Количество лайков
    ///   - sharedText: Количество поделившихся
    ///   - watchedText: Количество просмторевших
    ///   - imageName: Название картинки
    ///   - isLiked: Проверка на лайк
    func configure(mainText: String,
                   dateText: String,
                   placeText: String,
                   imageName: String,
                   likeText: Int,
                   sharedText: Int,
                   watchedText: Int,
                   isLiked: Bool) {
        let image = UIImage(named: imageName)
        
        mainLabel.text = mainText
        dateLabel.text = dateText
        placeInfoStackVeiw.configureStackVeiw(image: R.image.location.name,
                                              text: placeText)
        if isLiked {
            likeInfoStackVeiw.configureStackVeiw(image: R.image.likeTapped.name,
                                                 text: "\(likeText)")
        } else {
            likeInfoStackVeiw.configureStackVeiw(image: R.image.likes.name,
                                                 text: "\(likeText)")
        }
        sharedInfoStackView.configureStackVeiw(image: R.image.people.name,
                                               text: "\(sharedText)")
        watchedInfoStackView.configureStackVeiw(image: R.image.eye.name,
                                                text: "\(watchedText)")
        eventImageView.image = image
        isEventLiked = isLiked
    }
}
