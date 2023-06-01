//
//  ProfileViewProtocol.swift
//  OnWheels
//
//  Created by Артём on 07.04.2023.
//

import UIKit

protocol ProfileView: AnyObject, UIViewController {
    func setUserInfo(user: ProfileUserInfo)
}
