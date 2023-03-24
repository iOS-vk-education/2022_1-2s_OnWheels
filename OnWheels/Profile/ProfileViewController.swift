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

    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(systemSymbol: .bicycleCircle)
        return image
    }()

    private let nameLabel: UILabel = {
        let name = UILabel()
        name.text = "Name Surname"
        name.font = .systemFont(ofSize: 25, weight: .semibold)
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
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(systemSymbol: .rectanglePortraitAndArrowRight), for: .normal)
        button.setTitle(R.string.localizable.logout(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        return button
    }()

    private let deleteAccountButton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = UIImage(systemSymbol: .trash).withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.imageView?.tintColor = .systemRed
        button.setTitle(R.string.localizable.deleteAccount(), for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        return button
    }()

    private let detailsTable = UITableView(frame: .zero, style: .insetGrouped)
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
        updateData()
    }
}

// MARK: - UI
private extension ProfileViewController {
    func setupUI() {
        view.backgroundColor = .backgroundColor
        // variadic arguments
        setupUserDetailsTable()
        view.addSubviews(profileImage, nameLabel, cityLabel, detailsTable, deleteAccountButton, logoutButton)
        setupActions()
    }

    func setupActions() {
        deleteAccountButton.addTarget(self, action: #selector(deleteAccountButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    func setupUserDetailsTable() {
        detailsTable.separatorStyle = .singleLine
        detailsTable.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        detailsTable.showsVerticalScrollIndicator = false
        detailsTable.backgroundColor = .backgroundColor
        detailsTable.separatorColor = .gray
        detailsTable.delegate = self
        detailsTable.dataSource = self
        detailsTable.register(ProfileInfoCell.self)
        detailsTable.register(ProfileFooterCell.self)
        detailsTable.allowsSelection = true
        detailsTable.alwaysBounceVertical = false
    }

    func setupLayout() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.size.equalTo(150)
        }
        profileImage.makeRounded()

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        detailsTable.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
            make.bottom.equalTo(logoutButton.snp.top).inset(20)
        }

        logoutButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.left.equalTo(view.snp.centerX).offset(10)
            make.height.equalTo(50)
        }

        deleteAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.snp.centerX).inset(10)
            make.height.equalTo(50)
        }
    }


    func updateData() {
        if let user = user {
            nameLabel.text = user.firstname + " " + user.lastname
            cityLabel.text = user.city
        } else {
            nameLabel.text = "Unknown"
            cityLabel.text = "Unknown"
        }
        detailsTable.reloadData()
    }


    struct Constants {
        struct ProfileImage {
            static let widthPercent: Percent = 100%
            static let heightPercent: Percent = 35%
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
        if section == 0 {
            return 3
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(cellType: ProfileInfoCell.self, for: indexPath)
        cell.selectionStyle = .none

        switch indexPath.row {
        case 0:
            cell.configure(cellTitle: R.string.localizable.emailAdress(),
                    cellContent: user?.email)
        case 1:
            cell.configure(cellTitle: R.string.localizable.dateOfBirth(),
                    dateStr: user?.birthday)
        case 2:
            cell.configure(cellTitle: R.string.localizable.sex(),
                    cellContent: user?.sex)
        default:
            cell.clean()
        }
        return cell
    }


    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // container for padding
        let containerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        let padding: CGFloat = 5
        label.frame = CGRect.init(x: padding, y: padding, width: containerView.frame.width - padding * 2, height: containerView.frame.height - padding * 2)
        label.text = userDetailsTableTitles[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = .mainBlueColor
        containerView.addSubview(label)
        return containerView
    }

}

