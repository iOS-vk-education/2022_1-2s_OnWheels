//
//  ProfileInfoCell.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//

import Foundation
import UIKit

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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Main"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .systemBlue
        return label
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Main"
        label.font = .systemFont(ofSize: 12, weight: .light)
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
        NSLayoutConstraint.activate([
            cellInfoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            cellInfoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11),
            mainLabel.topAnchor.constraint(equalTo: cellInfoStackView.topAnchor),
            infoLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor)
        ])
    }
}
