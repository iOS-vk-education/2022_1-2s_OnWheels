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
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 16
        cell.layer.masksToBounds = true
        return cell
    }()
    
//    Заглавная надпись
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .mainBlueColor
        return label
    }()
    
//    Надпись времени события
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .orange
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCell()
        
        setupLayout()
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
        cellView.addSubview(eventImageView)
        
        cellView.addSubview(likeImageView)
        cellView.addSubview(likeLabel)
        
        cellView.addSubview(sharedImageView)
        cellView.addSubview(sharedLabel)
        
        cellView.addSubview(watchedImageView)
        cellView.addSubview(watchedLabel)
    }
    
    
    private func setupLayout() {
        
        cellView.pin
            .top(10)
            .height(UIScreen.main.bounds.height / 2 - 20)
            .left(10)
            .width(UIScreen.main.bounds.width - 20)
        mainLabel.pin
            .top(16)
            .left(24)
            .right(24)
            .minHeight(32)
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
        
        likeImageView.pin
            .bottom(10)
            .left(24)
            .width(18)
            .height(18)
        likeLabel.pin
            .bottom(10)
            .left(to: likeImageView.edge.right)
            .marginLeft(6)
            .width(32)
            .height(18)
        sharedImageView.pin
            .bottom(10)
            .left(to: likeLabel.edge.right)
            .width(18)
            .height(18)
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
            .width(18)
            .height(18)
            .marginLeft(40)
        watchedLabel.pin
            .bottom(10)
            .left(to: watchedImageView.edge.right)
            .width(32)
            .height(18)
            .marginLeft(6)
        
        eventImageView.pin
            .top(to: placeIconImageView.edge.bottom)
            .marginTop(11)
            .bottom(to: likeImageView.edge.top)
            .marginBottom(11)
            .left(12)
            .right(12)
            .minWidth(330)
        }
    
    /// заполнение ячейки данными
    /// - Parameters:
    ///   - mainText: Главный текст
    ///   - dateText: Время проведения
    ///   - placeText: Место проведения
    ///   - likeText: Количество лайков
    ///   - sharedText: Количество поделившихся
    ///   - watchedText: Количество просмторевших
    ///   - imahe: Название картинки
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
