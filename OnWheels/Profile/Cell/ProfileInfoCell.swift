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
    private let cellInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 2
        return stackView
    }()
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .systemBlue
        return label
    }()
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
    
    private func setupCell(){
        self.addSubview(cellInfoStackView)
        cellInfoStackView.addArrangedSubview(mainLabel)
        cellInfoStackView.addArrangedSubview(infoLabel)
        setupConstraints()
    }
    
    private func setupConstraints(){
        cellInfoStackView.pin
            .top(3)
            .left(11)
            .right(11)
            .bottom(3)
        mainLabel.pin
            .top(to: cellInfoStackView.edge.top)
            .left(to: cellInfoStackView.edge.left)
            .right(to: cellInfoStackView.edge.right)
//            .sizeToFit(.width)
//            .height(14)
        mainLabel.pin
            .top(to: mainLabel.edge.bottom)
            .left(to: cellInfoStackView.edge.left)
            .right(to: cellInfoStackView.edge.right)
            .bottom(to: cellInfoStackView.edge.bottom)
    }
    func configure(mainText: String, infoText: String){
        mainLabel.text = mainText
        infoLabel.text = infoText
    }
}
