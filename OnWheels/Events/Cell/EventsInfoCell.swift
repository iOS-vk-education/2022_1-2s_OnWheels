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
    
//    Местополжение события
    private let placeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.location()
        return imageView
    }()
    
    private let placeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .mainBlueColor
        return label
    }()
    
//    Главная картинка
    private let eventImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = R.image.eventImageBase()
        return imageView
    }()
    
//    Кнопка лайка
    private let likeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.likes()
        return imageView
    }()
    
    private var likeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .mainBlueColor
        return label
    }()
    
//    Кнопка поделившихся
    private let sharedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.people()
        return imageView
    }()
    
    private var sharedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .mainBlueColor
        return label
    }()
    
//    Кнопка просмотров
    private let watchedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.eye()
        return imageView
    }()
    
    private var watchedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .mainBlueColor
        return label
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
        
        cellView.addSubview(placeIconImageView)
        cellView.addSubview(placeLabel)
        
        cellView.addSubview(tagsStackVeiw)
        
        cellView.addSubview(eventImageView)
        
        cellView.addSubview(likeImageView)
        cellView.addSubview(likeLabel)
        
        cellView.addSubview(sharedImageView)
        cellView.addSubview(sharedLabel)
        
        cellView.addSubview(watchedImageView)
        cellView.addSubview(watchedLabel)
        setupLayout()
    }
    
    
    func setupLayout() {
        cellView.pin
            .top(10)
            .left()
            .right()
            .height(370)
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
        
        placeIconImageView.pin
            .top(to: dateLabel.edge.bottom)
            .marginTop(5)
            .left(24)
            .width(24)
            .height(24)
        
        placeLabel.pin
            .bottom(to: placeIconImageView.edge.bottom)
            .left(to: placeIconImageView.edge.right)
            .marginLeft(12)
            .marginBottom(4)
            .height(16)
            .right(24)
        
        tagsStackVeiw.pin
            .top(to: placeLabel.edge.bottom)
            .marginTop(10)
            .left(24)
            .right(24)
            .height(20)
        
        likeImageView.pin
            .bottom(10)
            .left(24)
            .width(24)
            .height(24)
        
        likeLabel.pin
            .bottom(10)
            .left(to: likeImageView.edge.right)
            .marginLeft(6)
            .width(32)
            .height(18)
        
        sharedImageView.pin
            .bottom(10)
            .left(to: likeLabel.edge.right)
            .width(24)
            .height(24)
            .marginLeft(40)
        
        sharedLabel.pin
            .bottom(10)
            .left(to: sharedImageView.edge.right)
            .width(32)
            .height(18)
            .marginLeft(6)
        
        watchedImageView.pin
            .bottom(10)
            .left(to: sharedLabel.edge.right)
            .width(24)
            .height(24)
            .marginLeft(40)
        
        watchedLabel.pin
            .bottom(10)
            .left(to: watchedImageView.edge.right)
            .width(32)
            .height(18)
            .marginLeft(6)
        
        eventImageView.pin
            .top(to: tagsStackVeiw.edge.bottom)
            .marginTop(11)
            .bottom(to: likeImageView.edge.top)
            .height(180)
            .left(12)
            .right(12)
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
        placeLabel.text = placeText
        likeLabel.text = likeText
        sharedLabel.text = sharedText
        watchedLabel.text = watchedText
        eventImageView.image = image
    }
}
