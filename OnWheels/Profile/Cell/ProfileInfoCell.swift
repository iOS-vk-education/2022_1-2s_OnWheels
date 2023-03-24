//
//  ProfileInfoCell.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//

import UIKit
import PinLayout

final class ProfileInfoCell: UITableViewCell {
    
    private let cellInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.textColor = R.color.mainBlue()
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = R.color.profileCellTextColor()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = R.color.cellColor()
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setupCell(){
        self.addSubview(cellInfoStackView)
        cellInfoStackView.addArrangedSubview(mainLabel)
        cellInfoStackView.addArrangedSubview(infoLabel)
        setupLayout()
    }
    
    
    private func setupLayout(){
        let cellInsets = UIEdgeInsets(top: 5, left: 11, bottom: 0, right: 11)
        cellInfoStackView.pin
            .top(cellInsets.top)
            .left(cellInsets.left)
            .right(cellInsets.right)
            .bottom(cellInsets.bottom)
    }
    
    /// заполнение ячейки данными
    /// - Parameters:
    ///   - cellTitle: Тип данных в ячейке (email, birthday, ...)
    ///   - cellContent: Информация о пользователе (test@test.com, 1.1.2003, ...)
    func configure(cellTitle: String, cellContent: String?) {
        mainLabel.text = cellTitle
        infoLabel.text = cellContent ?? "Unknown"
    }

    func configure(cellTitle: String, birthdayStr: String?) {
        mainLabel.text = cellTitle
        if let birthdayStr = birthdayStr {
            let formatter1 = DateFormatter()
            formatter1.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            formatter1.locale = Locale(identifier: "en_US_POSIX")
            var dateString = ""
            if let date2 = formatter1.date(from: birthdayStr) {
                let formatter2 = DateFormatter()
                formatter2.dateFormat = "EEEE, MMM d, yyyy"
                formatter2.locale = Locale(identifier: "en_US_POSIX")
                dateString = formatter2.string(from: date2)
            } else {
                dateString = "Error"
            }
            infoLabel.text = dateString
        } else {
            infoLabel.text = "Unknown"
        }
    }


    func clean() {
        mainLabel.text = "Error"
        infoLabel.text = "Error"
    }
}
