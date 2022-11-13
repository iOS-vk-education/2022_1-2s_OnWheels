//
//  ProfileFooter.swift
//  OnWheels
//
//  Created by Veronika on 13.11.2022.
//

import UIKit
import PinLayout

final class ProfileFooterCell: UITableViewCell {
    var action: (() -> Void)?
    
    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.deleteAccount(), for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupFooter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
}

extension ProfileFooterCell {
    func setupFooter() {
        self.addSubview(deleteAccountButton)
    }
    
    func setupLayout() {
        deleteAccountButton.pin
            .top(Constants.DeleteButton.top)
            .height(Constants.DeleteButton.height)
            .hCenter()
            .sizeToFit(.height)
            .bottom()
    }
    
    struct Constants {
        struct DeleteButton {
            static let top: CGFloat = 5
            static let height: CGFloat = 25
        }
    }
}
