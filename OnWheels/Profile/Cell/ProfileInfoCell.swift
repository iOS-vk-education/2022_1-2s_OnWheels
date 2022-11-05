//
//  ProfileInfoCell.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//

import Foundation
import UIKit
import PinLayout

final class ProfileInfoCell: UITableViewCell {
    
    // StackView для ячеек профиля с информацией о пользователе
    private let cellInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    
    // Верхний лейбл ячеек, название полей
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemBlue
        return label
    }()
    
    // Информация пользователя
    lazy var infoLabel: UILabel = {
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
    
    /// Добавление вью на ячейку
    private func setupCell(){
        self.addSubview(cellInfoStackView)
        cellInfoStackView.addArrangedSubview(mainLabel)
        cellInfoStackView.addArrangedSubview(infoLabel)
        setupLayout()
    }
    
    
    /// выстраивание отступов для вьюшек
    private func setupLayout(){
        cellInfoStackView.pin
            .top(Constants.CellInfoStackView.top)
            .left(Constants.CellInfoStackView.left)
            .right(Constants.CellInfoStackView.right)
            .bottom(Constants.CellInfoStackView.bottom)
//        mainLabel.pin
//            .top(to: cellInfoStackView.edge.top)
//            .left(to: cellInfoStackView.edge.left)
//            .right(to: cellInfoStackView.edge.right)
//            .sizeToFit(.width)
//            .height(14)
//        mainLabel.pin
//            .top(to: mainLabel.edge.bottom)
//            .left(to: cellInfoStackView.edge.left)
//            .right(to: cellInfoStackView.edge.right)
//            .bottom(to: cellInfoStackView.edge.bottom)
    }
    
    struct Constants {
        struct CellInfoStackView {
            static let top: CGFloat = 3
            static let left: CGFloat = 11
            static let right: CGFloat = 11
            static let bottom: CGFloat = 3
        }
    }
    
    /// заполнение ячейки данными
    func configure(mainText: String, infoText: String){
        mainLabel.text = mainText
        infoLabel.text = infoText
    }
}
