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
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "ProfileImage")
        return image
    }()
    
    let profileInfo: UIStackView = {
        let info = UIStackView()
        info.translatesAutoresizingMaskIntoConstraints = false
        info.alignment = .leading
        info.axis = .vertical
        info.spacing = 5
        return info
    }()
    let personName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "Name Surname"
        name.font = .systemFont(ofSize: 20, weight: .regular)
        name.textColor = UIColor(named: "profileText")
        return name
    }()
    let personCity: UILabel = {
        let city = UILabel()
        city.translatesAutoresizingMaskIntoConstraints = false
        city.text = "City"
        city.textColor = UIColor(named: "profileText")
        city.font = .systemFont(ofSize: 16, weight: .light)
        return city
    }()
    
    private let personTableView = UITableView(frame: .zero, style: .insetGrouped)

    let headerTitles = ["О себе", "Мои соцсети"]
    
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
        setupConstraints()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
}

extension ProfileViewController: ProfileViewInput {
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.topAnchor),
            profileImage.widthAnchor.constraint(equalToConstant: view.bounds.width),
            profileImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 2.3),
            profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            profileInfo.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: -31),
            profileInfo.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor, constant: 30),
            personName.topAnchor.constraint(equalTo: profileInfo.topAnchor),
            personName.leadingAnchor.constraint(equalTo: profileInfo.leadingAnchor),
            personCity.topAnchor.constraint(equalTo: personName.bottomAnchor),
            personCity.leadingAnchor.constraint(equalTo: profileInfo.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            personTableView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            personTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            personTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -31)
        ])
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
        personTableView.translatesAutoresizingMaskIntoConstraints = false
        personTableView.separatorStyle = .singleLine
        personTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0)
        personTableView.separatorColor = .white
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "profile", for: indexPath) as UITableViewCell
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
