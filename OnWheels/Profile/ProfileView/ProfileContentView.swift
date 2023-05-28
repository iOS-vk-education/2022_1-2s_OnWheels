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
    private let detailsLabel = UILabel(frame: .zero)
    private let profileDetails = UIStackView(frame: .zero)
    private let logoutButton = CustomButton(frame: .zero)
    private let deleteAccountButton = CustomButton(frame: .zero)
    
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
        userAvatar.image = R.image.profileImage()
        backgroundColor = .systemGray5
        userAvatar.contentMode = .scaleAspectFit
        detailsLabel.text = R.string.localizable.aboutMe()
        detailsLabel.font = .systemFont(ofSize: 17, weight: .regular)
        detailsLabel.textColor = R.color.mainBlue()

        userNameLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        setupLogoutButton()
        setupDeleteButton()
        setupStackview()
    }
    
    func placeElements() {
        let subviews = [userAvatar, userNameLabel, userCityLabel,
                        profileDetails, detailsLabel, deleteAccountButton, logoutButton]
        subviews.forEach {
            box in
            self.addSubview(box)
        }
    }
    
    func setupConstraints() {
        userAvatar.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(-15)
            make.width.height.equalTo(115)
        }
        userAvatar.makeRounded(width: 115)
        
        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userAvatar.snp.bottom).offset(20)
        }
        
        userCityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
        }
        
        profileDetails.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).offset(-20)
            make.top.equalTo(userCityLabel.snp.bottom).offset(50)
        }
        profileDetails.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        profileDetails.isLayoutMarginsRelativeArrangement = true
        profileDetails.layer.masksToBounds = false
        profileDetails.layer.cornerRadius = 10
        profileDetails.clipsToBounds = true
        
        detailsLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileDetails.snp.top).offset(-7)
            make.left.equalTo(profileDetails.snp.left).offset(15)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(profileDetails.snp.bottom).offset(15)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(20)
            make.left.equalTo(self.snp.centerX).offset(10)
            make.height.equalTo(70)
        }
        deleteAccountButton.snp.makeConstraints { make in
            make.top.equalTo(profileDetails.snp.bottom).offset(15)
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.snp.centerX).inset(10)
            make.height.equalTo(70)
        }
    }
    
    func setupStackview() {
        // email, birthday, sex
        profileDetails.axis = .vertical
        profileDetails.alignment = .leading
        profileDetails.spacing = 7
        profileDetails.backgroundColor = R.color.cellColor()
        initStackview()
    }
    
    // MARK: - buttons initialization
    func setupLogoutButton() {
        let button = logoutButton
        button.configureViewWith(text: R.string.localizable.logoutButtonText(), textColor: R.color.profileCellTextColor(), image: UIImage(systemSymbol: .rectanglePortraitAndArrowRight))
        button.setprofileAction(logoutButtonTapped)
        button.layer.cornerRadius = 10
    }
    
    func setupDeleteButton() {
        let button = deleteAccountButton
        button.configureViewWith(text: R.string.localizable.deleteAccountButtonText(), textColor: R.color.profileCellTextColor(), image: UIImage(systemSymbol: .trash).withRenderingMode(.alwaysTemplate))
        button.setprofileAction(deleteButtonTapped)
        button.actionLabel.textColor = .red
        button.actionImageView.tintColor = .red
        button.layer.cornerRadius = 10
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
        userNameLabel.text = user.fullName
        userCityLabel.text = user.city
        updateStackview(email: user.email, birthday: user.birthday, sex: user.sex)
    }
    
    enum profileDetailsViewEnum: Int {
        case emailLabel = 1, birthdayLabel = 2, sexLabel = 3
    }
    
    func initStackview() {
        profileDetails.removeFullyAllArrangedSubviews()
        
        let emailDescriptionLabel = UILabel()
        emailDescriptionLabel.text = R.string.localizable.emailAdress()
        emailDescriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        emailDescriptionLabel.textColor = R.color.mainBlue()
        
        let emailLabel = UILabel()
        emailLabel.tag = profileDetailsViewEnum.emailLabel.rawValue
        //emailLabel.text = email
        emailLabel.font = .systemFont(ofSize: 16, weight: .regular)
        emailLabel.textColor = R.color.profileCellTextColor()
        
        profileDetails.addArrangedSubviews(emailDescriptionLabel, emailLabel)
        
        let firstSeparator = UIView()
        firstSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        firstSeparator.backgroundColor = .systemGray
        profileDetails.addArrangedSubview(firstSeparator)
        firstSeparator.widthAnchor.constraint(equalTo: profileDetails.widthAnchor, multiplier: 0.93).isActive = true
        
        let birthdayDescriptionLabel = UILabel()
        birthdayDescriptionLabel.text = R.string.localizable.dateOfBirth()
        birthdayDescriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        birthdayDescriptionLabel.textColor = R.color.mainBlue()
        
        let birthdayLabel = UILabel()
        birthdayLabel.tag = profileDetailsViewEnum.birthdayLabel.rawValue

        birthdayLabel.font = .systemFont(ofSize: 16, weight: .regular)
        birthdayLabel.textColor = R.color.profileCellTextColor()
        
        profileDetails.addArrangedSubviews(birthdayDescriptionLabel, birthdayLabel)
        
        let secondSeparator = UIView()
        secondSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        secondSeparator.backgroundColor = .systemGray
        profileDetails.addArrangedSubview(secondSeparator)
        secondSeparator.widthAnchor.constraint(equalTo: profileDetails.widthAnchor, multiplier: 0.93).isActive = true
        
        let sexDescriptionLabel = UILabel()
        sexDescriptionLabel.text = R.string.localizable.sex()
        sexDescriptionLabel.font = .systemFont(ofSize: 16, weight: .light)
        sexDescriptionLabel.textColor = R.color.mainBlue()
        
        let sexLabel = UILabel()
        sexLabel.tag = profileDetailsViewEnum.sexLabel.rawValue
        sexLabel.font = .systemFont(ofSize: 16, weight: .regular)
        sexLabel.textColor = R.color.profileCellTextColor()
        
        profileDetails.addArrangedSubviews(sexDescriptionLabel, sexLabel)
    }
    
    private func updateStackview(email: String, birthday: String, sex: String) {
        // TODO: навести красивости
        let emailLabel = profileDetails.viewWithTag(profileDetailsViewEnum.emailLabel.rawValue)! as! UILabel
        let birthdayLabel = profileDetails.viewWithTag(profileDetailsViewEnum.birthdayLabel.rawValue)! as! UILabel
        let sexLabel = profileDetails.viewWithTag(profileDetailsViewEnum.sexLabel.rawValue)! as! UILabel
        
        emailLabel.text = email
        let dateString: String = recodeDateString(birthday: birthday)
        birthdayLabel.text = dateString
        sexLabel.text = sex
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
