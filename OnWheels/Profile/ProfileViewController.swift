//
//  ProfileViewController.swift
//  OnWheels
//
//  Created by Veronika on 29.10.2022.
//  
//

import UIKit
import PinLayout

final class ProfileViewController: UIViewController {
    private let output: ProfileViewOutput
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = R.image.profileImage()
        return image
    }()
    
    private let changeProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle(R.string.localizable.change(), for: .normal)
        button.setTitleColor(.whiteTextColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.logoutButton(), for: .normal)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let profileInfo: UIStackView = {
        let info = UIStackView()
        info.alignment = .leading
        info.axis = .vertical
        info.spacing = 5
        return info
    }()
    
    private let personName: UILabel = {
        let name = UILabel()
        name.text = "Name Surname"
        name.font = .systemFont(ofSize: 20, weight: .regular)
        name.textColor = .whiteTextColor
        return name
    }()
    
    private let personCity: UILabel = {
        let city = UILabel()
        city.text = "City"
        city.textColor = .whiteTextColor
        city.font = .systemFont(ofSize: 16, weight: .light)
        return city
    }()
    
    private let personTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let headerTitles = [R.string.localizable.aboutMe(),
                                R.string.localizable.mySocialNetworks()]
    
    
    init(output: ProfileViewOutput) {
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayout()
    }
    
    
    @objc
    func changeProfileButtonTapped(){
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.changeProfileButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.openChangeProfileScreen()
                self?.changeProfileButton.alpha = 1
            }
        }
    }
    
    @objc
    func logoutButtonAction(){
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.changeProfileButton.alpha = 0.7
        } completion: { [weak self] finished in
            if finished {
                self?.output.logoutButtonTapped()
                self?.changeProfileButton.alpha = 1
            }
        }
    }
    
}

extension ProfileViewController: ProfileViewInput {
    
}

extension ProfileViewController {
    
    private func setupLayout(){
        profileImage.pin
            .top()
            .right()
            .left()
            .width(Constants.ProfileImage.widthPercent)
            .height(Constants.ProfileImage.heightPercent)
        
        profileInfo.pin
            .top(to: profileImage.edge.top).marginTop(Constants.ProfileInfo.marginTopPercent)
            .left(to: profileImage.edge.left).marginLeft(Constants.ProfileInfo.marginLeft)
            .right()
            .height(profileImage.bounds.height * Constants.ProfileInfo.heightPercent)
        
        personTableView.pin
            .top(to: profileImage.edge.bottom).marginTop(Constants.PersonTableView.marginTop)
            .left()
            .right()
            .bottom()
    }
    
    private func setupUI(){
        view.backgroundColor = .backgroundColor
        view.addSubview(profileImage)
        profileImage.addSubview(changeProfileButton)
        profileImage.addSubview(logoutButton)
        changeProfileButton.bringSubviewToFront(profileImage)
        profileImage.addSubview(profileInfo)
        profileInfo.addArrangedSubview(personName)
        profileInfo.addArrangedSubview(personCity)
        view.addSubview(personTableView)
        setupTableView()
        setupNavBar()
    }
    
    private func setupTableView(){
        personTableView.separatorStyle = .singleLine
        personTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        personTableView.showsVerticalScrollIndicator = false
        personTableView.backgroundColor = .backgroundColor
        personTableView.separatorColor = .gray
        personTableView.delegate = self
        personTableView.dataSource = self
        personTableView.register(ProfileInfoCell.self)
        personTableView.register(ProfileFooterCell.self)
        personTableView.allowsSelection = true
    }
    
    func setupNavBar (){
        changeProfileButton.addTarget(self, action: #selector(changeProfileButtonTapped), for: .touchUpInside)
        let leftNavBarItem = UIBarButtonItem(customView: changeProfileButton)
        self.navigationItem.setLeftBarButton(leftNavBarItem, animated: true)
        logoutButton.addTarget(self, action: #selector(logoutButtonAction), for: .touchUpInside)
        let rightNavBarItem = UIBarButtonItem(customView: logoutButton)
        self.navigationItem.setRightBarButton(rightNavBarItem, animated: true)
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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        switch section {
        case 0:
            numberOfRows = 5
        case 1:
            numberOfRows = 3
        case 2:
            numberOfRows = 1
        default:
            break
        }
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell = tableView.dequeueCell(cellType: ProfileInfoCell.self, for: indexPath)
            cell.selectionStyle = .none
            if indexPath.section == 0 {
                switch indexPath.row {
                case 0:
                    cell.configure(mainText: R.string.localizable.phoneNumber(),
                                   infoText: "+79000000000")
                case 1:
                    cell.configure(mainText: R.string.localizable.emailAdress(),
                                   infoText: "name@ya.ru")
                case 2:
                    cell.configure(mainText: R.string.localizable.dateOfBirth(),
                                   infoText: "01.01.2001")
                case 3:
                    cell.configure(mainText: R.string.localizable.sex(),
                                   infoText: "муж")
                case 4:
                    cell.configure(mainText: R.string.localizable.aboutMe(),
                                   infoText: "Нет информации")
                default:
                    break
                }
            } else {
                switch indexPath.row {
                case 0:
                    cell.configure(mainText: R.string.localizable.telegram(),
                                   infoText: "t.me")
                case 1:
                    cell.configure(mainText: R.string.localizable.youtube(),
                                   infoText: "youtube.com")
                case 2:
                    cell.configure(mainText: R.string.localizable.vk(),
                                   infoText: "vk.com")
                default:
                    break
                }
                
            }
            return cell
        } else {
            let cell = tableView.dequeueCell(cellType: ProfileFooterCell.self, for: indexPath)
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            self.output.deleteAccountButtonTapped()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 30
        } else {
            return 48
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 0
        } else {
            return 32
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 32))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-7)
        label.text = headerTitles[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .light)
        label.textColor = .mainBlueColor
        
        headerView.addSubview(label)
        
        return headerView
    }
    
}

