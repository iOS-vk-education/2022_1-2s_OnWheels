//
// Created by Артём on 03.04.2023.
//

import UIKit
import SnapKit
import SFSafeSymbols
import RswiftResources

typealias ProfileLogoutAction = () -> Void
typealias ProfileDeleteAction = () -> Void

class ProfileView: UIView {
    private let userAvatar = UIImageView(frame: .zero)
    private let userNameLabel = UILabel(frame: .zero)
    private let userCityLabel = UILabel(frame: .zero)
    private let profileDetails = UIStackView(frame: .zero)
    private let logoutButton = UIButton(frame: .zero)
    private let deleteAccountButton = UIButton(frame: .zero)

    private var profileLogoutAction: ProfileLogoutAction?
    private var profileDeleteAction: ProfileDeleteAction?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - actions setups
extension ProfileView {
    func setProfileDetailButtonAction(_ action: @escaping ProfileLogoutAction) {
        self.profileLogoutAction = action
    }

    func setSettingsButtonAction(_ action: @escaping ProfileDeleteAction) {
        self.profileDeleteAction = action
    }
}


// MARK: - UI
private extension ProfileView {
    func setupUI() {
        self.backgroundColor = .white
        userAvatar.image = UIImage(systemSymbol: .personCircle)
        profileDeleteButtonConf()
        profileLogoutButtonConf()
        // .. setup stackview
        [userAvatar, userNameLabel, userCityLabel, profileDetails, deleteAccountButton, logoutButton].forEach {
            box in
            self.addSubview(box)
        }
        setupConstraints()
    }

    func setupConstraints() {
        // smth like that:
//        userLogo.snp.makeConstraints { make in
//            make.centerX.equalTo(self.safeAreaLayoutGuide)
//            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
//            make.size.equalTo(50)
//        }
    }

    // MARK: - button configs
    func profileLogoutButtonConf() {
        var config = largeButtonConf(button: logoutButton)
        config.title = R.string.localizable.logout_button_text()
        logoutButton.configuration = config
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped),
                for: .touchUpInside)

    }

    func profileDeleteButtonConf() {
        var config = largeButtonConf(button: deleteAccountButton)
        config.title = R.string.localizable.delete_account_button_text()
        deleteAccountButton.configuration = config
        deleteAccountButton.addTarget(self, action: #selector(deleteButtonTapped),
                for: .touchUpInside)

    }
}

// MARK: - UI actions
private extension ProfileView {
    @objc func logoutButtonTapped() {
        self.profileLogoutAction?()
    }

    @objc func deleteButtonTapped() {
        self.profileDeleteAction?()
    }
}
