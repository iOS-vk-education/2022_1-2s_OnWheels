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
    let likeInfoStackVeiw = EventInfoStackView()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(){
        addSubview(cellView)
        
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
            .top(10)
            .left()
            .right()
            .height(390)
            .bottom(10)
        
        mainLabel.pin
            .top(16)
            .left(24)
            .right(24)
            .height(50)
        
        dateLabel.pin
            .top(to: mainLabel.edge.bottom)
            .marginTop(5)
            .left(24)
            .right(24)
            .height(14)
        
        placeInfoStackVeiw.pin
            .top(to: dateLabel.edge.bottom)
            .marginTop(8)
            .left(24)
            .height(30)
            .width(200)
        
        tagsStackVeiw.pin
            .top(to: placeInfoStackVeiw.edge.bottom)
            .marginTop(10)
            .left(24)
            .right(24)
            .height(20)
        
        eventImageView.pin
            .top(to: tagsStackVeiw.edge.bottom)
            .marginTop(12)
            .height(180)
            .left(12)
            .right(12)
        
        likeInfoStackVeiw.pin
            .top(to: eventImageView.edge.bottom)
            .marginTop(10)
            .left(24)
            .width(50)
            .height(24)
        
        sharedInfoStackView.pin
            .top(to: eventImageView.edge.bottom)
            .marginTop(10)
            .left(to: likeInfoStackVeiw.edge.right)
            .marginLeft(24)
            .width(50)
            .height(24)
        
        watchedInfoStackView.pin
            .top(to: eventImageView.edge.bottom)
            .marginTop(10)
            .left(to: sharedInfoStackView.edge.right)
            .marginLeft(24)
            .width(50)
            .height(24)
    }
    
    func setupLikeStackView(){
        likeInfoStackVeiw.isUserInteractionEnabled = true
        likeInfoStackVeiw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(setState)))
        likeInfoStackVeiw.resignFirstResponder()
    }
    
    @objc
    func setState(at state: Bool) {
        if state {
            likeInfoStackVeiw.infoImageView.image = R.image.likes()
            print("like")
        } else {
            likeInfoStackVeiw.infoImageView.image = R.image.likes()
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
    func configure(mainText: String,
                   dateText: String,
                   placeText: String,
                   imageName: String,
                   likeText: String,
                   sharedText: String,
                   watchedText: String) {
        let image = UIImage(named: imageName)
        
        mainLabel.text = mainText
        dateLabel.text = dateText
        placeInfoStackVeiw.configureStackVeiw(image: R.image.location.name,
                                              text: placeText)
        likeInfoStackVeiw.configureStackVeiw(image: R.image.likes.name,
                                             text: likeText)
        sharedInfoStackView.configureStackVeiw(image: R.image.people.name,
                                               text: sharedText)
        watchedInfoStackView.configureStackVeiw(image: R.image.eye.name,
                                                text: watchedText)
        eventImageView.image = image
    }
}
