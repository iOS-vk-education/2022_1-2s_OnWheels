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
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemBlue
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell(){
        self.addSubview(cellInfoStackView)
        cellInfoStackView.addArrangedSubview(mainLabel)
        cellInfoStackView.addArrangedSubview(infoLabel)
        setupLayout()
    }
    
    
    private func setupLayout(){
        let cellInsets = UIEdgeInsets(top: 3, left: 11, bottom: 3, right: 11)
        cellInfoStackView.pin
            .top(cellInsets.top)
            .left(cellInsets.left)
            .right(cellInsets.right)
            .bottom(cellInsets.bottom)
    }
    
    /// заполнение ячейки данными
    /// - Parameters:
    ///   - mainText: Главный текст
    ///   - infoText: Информация о пользователе
    func configure(mainText: String, infoText: String){
        mainLabel.text = mainText
        infoLabel.text = infoText
    }
}
