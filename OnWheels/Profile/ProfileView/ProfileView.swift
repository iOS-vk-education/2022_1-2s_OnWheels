//
//  ProfileViewProtocol.swift
//  OnWheels
//
//  Created by Артём on 07.04.2023.
//

import Foundation

protocol ProfileView: AnyObject {
    func setUserInfo(user: CurrentUser)
}
