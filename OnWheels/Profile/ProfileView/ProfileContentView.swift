//
// Created by Артём on 03.04.2023.
//

import UIKit
import SnapKit
import SFSafeSymbols
import RswiftResources


class ProfileContentView: UIView {
    typealias ProfileLogoutAction = () -> Void
    typealias ProfileDeleteAction = () -> Void

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
extension ProfileContentView {
    func setProfileDetailButtonAction(_ action: @escaping ProfileLogoutAction) {
        self.profileLogoutAction = action
    }

    func setSettingsButtonAction(_ action: @escaping ProfileDeleteAction) {
        self.profileDeleteAction = action
    }
}


// MARK: - UI
private extension ProfileContentView {
    func setupUI() {
        initElements()
        placeElements()
        setupConstraints()
        setupConstraints()
    }

    
    func initElements() {
        self.backgroundColor = .white
        userAvatar.image = UIImage(systemSymbol: .personCircle)
        setupLogoutButton()
        setupDeleteButton()
        // .. fill stackview
        
    }
    
    
    func placeElements() {
        let subviews = [userAvatar, userNameLabel, userCityLabel,
                        profileDetails, deleteAccountButton, logoutButton]
        subviews.forEach {
            box in
            self.addSubview(box)
        }
    }
    
    
    func setupConstraints() {
        // smth like that:
//        userLogo.snp.makeConstraints { make in
//            make.centerX.equalTo(self.safeAreaLayoutGuide)
//            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
//            make.size.equalTo(50)
//        }
    }

    // MARK: - buttons initialization
    func setupLogoutButton() {
        var config = logoutButton.largeButtonConf()
        config.title = R.string.localizable.logout_button_text()
        logoutButton.configuration = config
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped),
                for: .touchUpInside)

    }

    func setupDeleteButton() {
        var config = deleteAccountButton.largeButtonConf()
        config.title = R.string.localizable.delete_account_button_text()
        deleteAccountButton.configuration = config
        deleteAccountButton.addTarget(self, action: #selector(deleteButtonTapped),
                for: .touchUpInside)

    }
}

// MARK: - UI actions
private extension ProfileContentView {
    @objc func logoutButtonTapped() {
        self.profileLogoutAction?()
    }

    @objc func deleteButtonTapped() {
        self.profileDeleteAction?()
    }
}
