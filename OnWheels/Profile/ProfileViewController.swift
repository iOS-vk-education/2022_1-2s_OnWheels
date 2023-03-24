//
//  ProfileViewController.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import UIKit
import PinLayout
import SnapKit
import SFSafeSymbols

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    private var user: CurrentUser?

    private var name: String = ""
    private var surname: String = ""
    private var city: String = ""
    private var sex: String = ""
    private var birthday: String = ""

    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = R.image.profileImage()
        image.layer.cornerRadius = 20
        return image
    }()

    private let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Name Surname"
        name.font = .systemFont(ofSize: 20, weight: .regular)
        name.textColor = .black
        return name
    }()

    private let cityLabel: UILabel = {
        let city = UILabel()
        city.text = "City"
        city.font = .systemFont(ofSize: 16, weight: .light)
        city.textColor = .black
        return city
    }()

    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemSymbol: .rectanglePortraitAndArrowRight), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    private let deleteAccountButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemSymbol: .trash), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()

    private let userDetailsTable = UITableView(frame: .zero, style: .insetGrouped)
    private let userDetailsTableTitles = [R.string.localizable.aboutMe()]

    init(output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        nil
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
        output.loadInfo()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }

    @objc
    func logoutButtonTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.logoutButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.logout()
                self?.logoutButton.alpha = 1
            }
        }
    }

    @objc
    func deleteAccountButtonTapped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.deleteAccountButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.deleteAccount()
                self?.deleteAccountButton.alpha = 1
            }
        }
    }
}

extension ProfileViewController: ProfileViewInput {
    func setUser(to newUser: CurrentUser) {
        user = newUser
        userDetailsTable.reloadData()

        // можем использовать "!", т.к. только что записали туда не опционал
        name = user!.firstname + " " + user!.lastname
        city = user!.city
    }
}

// MARK: - UI
extension ProfileViewController {
    private func setupUI() {
        view.backgroundColor = .backgroundColor
        // variadic arguments
        view.addSubviews(profileImage, nameLabel, cityLabel, userDetailsTable, deleteAccountButton, logoutButton)
        setupUserDetailsTable()
    }

    private func setupUserDetailsTable() {
        userDetailsTable.separatorStyle = .singleLine
        userDetailsTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        userDetailsTable.showsVerticalScrollIndicator = false
        userDetailsTable.backgroundColor = .backgroundColor
        userDetailsTable.separatorColor = .gray
        userDetailsTable.delegate = self
        userDetailsTable.dataSource = self
        userDetailsTable.register(ProfileInfoCell.self)
        userDetailsTable.register(ProfileFooterCell.self)
        userDetailsTable.allowsSelection = true
    }

    private func setupLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.size.equalTo(75)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        userDetailsTable.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(250)
        }

        deleteAccountButton.snp.makeConstraints { make in
            make.top.equalTo(userDetailsTable.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(deleteAccountButton.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    struct Constants {
        struct ProfileImage {
            static let widthPercent: Percent = 100%
            static let heightPercent: Percent = 35%
        }

        struct ChangeProfileButton {
            static let marginTopPercent: Percent = 10%
            static let marginLeftPercent: Percent = 5%
            static let width: CGFloat = 50
        }

        struct LogoutButton {
            static let marginTopPercent: Percent = 10%
            static let marginRightPercent: Percent = 5%
            static let width: CGFloat = 50
        }

        struct ProfileInfo {
            static let marginTopPercent: Percent = 80%
            static let marginLeft: CGFloat = 31
            static let heightPercent: CGFloat = 0.18
        }

        struct PersonTableView {
            static let marginTop: CGFloat = 0
        }
    }

}


// MARK: - Table
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
//        if section == 0 {
//            return 4
//        } else {
//            return 0
//        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: ProfileInfoCell.self, for: indexPath)
        cell.selectionStyle = .none

        switch indexPath.row {
        case 0:
            cell.configure(cellTitle: R.string.localizable.emailAdress(),
                    cellContent: user?.email)
        case 1:
            cell.configure(cellTitle: R.string.localizable.dateOfBirth(),
                    birthdayStr: user?.birthday)
        case 2:
            cell.configure(cellTitle: R.string.localizable.sex(),
                    cellContent: user?.sex)
        default:
            cell.clean()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 32))

        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width - 10, height: headerView.frame.height - 7)
        label.text = userDetailsTableTitles[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = .mainBlueColor
        headerView.addSubview(label)

        return headerView
    }

}

