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
        image.image = UIImage(named: "ProfileImage")
        return image
    }()
    
    let profileInfo: UIStackView = {
        let info = UIStackView()
        info.alignment = .leading
        info.axis = .vertical
        info.spacing = 5
        return info
    }()
    let personName: UILabel = {
        let name = UILabel()
        name.text = "Name Surname"
        name.font = .systemFont(ofSize: 20, weight: .regular)
        name.textColor = UIColor(named: "profileText")
        return name
    }()
    let personCity: UILabel = {
        let city = UILabel()
        city.text = "City"
        city.textColor = UIColor(named: "profileText")
        city.font = .systemFont(ofSize: 16, weight: .light)
        return city
    }()
    
    private let personTableView = UITableView(frame: .zero, style: .insetGrouped)

    let headerTitles = ["О себе", "Мои соцсети"]
    let mainLabels = ["Телефон", "Почта", "Дата рождения", "Телефон", "О себе","Телеграмм", "ВК", "Ютуб"]
//    let infoLabels = []
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
        setupConstraints()
    }
    
}

extension ProfileViewController: ProfileViewInput {
    private func setupConstraints(){
        profileImage.pin
            .top()
            .right()
            .left()
            .width(100%)
            .height(40%)
        
        profileInfo.pin
            .top(to: profileImage.edge.top).marginTop(80%)
            .bottom(to: profileImage.edge.bottom).marginBottom(7%)
            .left(to: profileImage.edge.left).marginLeft(31)
            .right()
        personTableView.pin
            .below(of: profileImage)
            .top(to: profileImage.edge.bottom).marginTop(10)
            .left(31)
            .right(31)
            .bottom(to: view.edge.bottom)
    }
    private func setupUI(){
        view.backgroundColor = UIColor(named: "profileBackground")
        view.addSubview(profileImage)
        profileImage.addSubview(profileInfo)
        profileInfo.addArrangedSubview(personName)
        profileInfo.addArrangedSubview(personCity)
        view.addSubview(personTableView)
        setupTableView()
    }
    
    private func setupTableView(){
        personTableView.separatorStyle = .singleLine
        personTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        personTableView.showsVerticalScrollIndicator = false
        personTableView.backgroundColor = UIColor(named: "profileBackground")
        personTableView.separatorColor = .gray
        personTableView.delegate = self
        personTableView.dataSource = self
        personTableView.register(ProfileInfoCell.self, forCellReuseIdentifier: "profile")
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as! ProfileInfoCell
        cell.mainLabel.text = mainLabels[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < headerTitles.count {
            return headerTitles[section]
        }

        return nil
    }
    
}
