//
// Created by Артём on 03.04.2023.
//

import UIKit
import SnapKit
import SFSafeSymbols
import RswiftResources


final class ProfileContentView: UIView {
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
    func setLogoutAction(_ action: @escaping ProfileLogoutAction) {
        self.profileLogoutAction = action
    }
    
    func setDeleteAction(_ action: @escaping ProfileDeleteAction) {
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
        userAvatar.image = R.image.profileImage()
        userNameLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        setupLogoutButton()
        setupDeleteButton()
        setupStackview()
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
        // TODO: сделать
        userAvatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(80)
        }
        
        userCityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userAvatar.snp.bottom).offset(20)
        }
        
        profileDetails.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints { make in
           make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(50)
           make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(20)
           make.left.equalTo(self.snp.centerX).offset(10)
           make.height.equalTo(50)
        }
       deleteAccountButton.snp.makeConstraints { make in
           make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(50)
           make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
           make.right.equalTo(self.snp.centerX).inset(10)
           make.height.equalTo(50)
       }
    }
    
    
    func setupStackview() {
        // email, birthday, sex
        profileDetails.axis = .vertical
        profileDetails.alignment = .leading
    }
    
    // MARK: - buttons initialization
    func setupLogoutButton() {
        let button = logoutButton
        var config = UIButton.largeButtonConf()
        config.title = R.string.localizable.logoutButtonText()
        config.image = UIImage(systemSymbol: .rectanglePortraitAndArrowRight)
        config.background.strokeColor = .systemBlue
        button.configuration = config
        
        button.addTarget(self, action: #selector(logoutButtonTapped),
                         for: .touchUpInside)
    }
    
    func setupDeleteButton() {
        let button = deleteAccountButton
        var config = UIButton.largeButtonConf()
        config.title = R.string.localizable.deleteAccountButtonText()
        config.background.strokeColor = .red
        config.baseForegroundColor = .red
        config.image = UIImage(systemSymbol: .trash).withRenderingMode(.alwaysTemplate).withTintColor(.red)
        button.configuration = config
        
        button.addTarget(self, action: #selector(deleteButtonTapped),
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

extension ProfileContentView {
    func setUserInfo(user: ProfileUserInfo) {
        userNameLabel.text = user.name
        userCityLabel.text = user.city
        updateStackview(email: user.email, birthday: user.birthday, sex: user.sex)
    }
    
    private func updateStackview(email: String, birthday: String, sex: String) {
        // TODO: навести красивости
        let emailDescriptionLabel = UILabel()
        emailDescriptionLabel.text = R.string.localizable.emailAdress()
        let emailLabel = UILabel()
        emailLabel.text = email
        
        let birthdayDescriptionLabel = UILabel()
        birthdayDescriptionLabel.text = R.string.localizable.dateOfBirth()
        let birthdayLabel = UILabel()
        let dateString: String = recodeDateString(birthday: birthday)
        birthdayLabel.text = dateString
        
        let sexDescriptionLabel = UILabel()
        sexDescriptionLabel.text = R.string.localizable.sex()
        let sexLabel = UILabel()
        sexLabel.text = sex
        profileDetails.removeFullyAllArrangedSubviews()
        profileDetails.addArrangedSubviews(emailDescriptionLabel, emailLabel, birthdayDescriptionLabel, birthdayLabel, sexDescriptionLabel, sexLabel)
    }
    
    private func recodeDateString(birthday: String) -> String {
        var dateString = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = DateFormatter.backendDateStringFormat
        if let date2 = inputFormatter.date(from: birthday) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = DateFormatter.frontednDateDisplayFormat
            dateString = outputFormatter.string(from: date2)
        } else {
            dateString = "Error"
        }
        return dateString
    }
}
