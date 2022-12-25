//
//  UserModel.swift
//  OnWheels
//
//  Created by Veronika on 24.12.2022.
//

import Foundation

struct Login {
    let email: String
    let password: String
}

extension Login {
    enum LoginCodingKeys: CodingKey {
        case email
        case password
    }
    init(from decoder: Decoder) throws {
        let loginContainer = try decoder.container(keyedBy: LoginCodingKeys.self)
        
        email = try loginContainer.decode(String.self, forKey: .email)
        password = try loginContainer.decode(String.self, forKey: .password)
    }
}

struct Register {
    let firstname: String
    let lastname: String
    let email: String
    let password: String
    let city: String
    let birthday: Date
    let sex: Bool
}

extension Register {
    enum RegisterCodingKeys: CodingKey {
        case firstname
        case lastname
        case email
        case password
        case city
        case birthday
        case sex
    }
    
    init(from decoder: Decoder) throws {
        let registerContainer = try decoder.container(keyedBy: RegisterCodingKeys.self)
        
        firstname = try registerContainer.decode(String.self, forKey: .firstname)
        lastname = try registerContainer.decode(String.self, forKey: .lastname)
        email = try registerContainer.decode(String.self, forKey: .email)
        password = try registerContainer.decode(String.self, forKey: .password)
        city = try registerContainer.decode(String.self, forKey: .city)
        birthday = try registerContainer.decode(Date.self, forKey: .birthday)
        sex = try registerContainer.decode(Bool.self, forKey: .sex)
    }
}

struct UserInfo {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let sex: String
    let city: String
    let birthday: Date
}
extension UserInfo {
    enum RegisterCodingKeys: CodingKey {
        case id
        case firstname
        case lastname
        case email
        case city
        case birthday
        case sex
    }
    
    init(from decoder: Decoder) throws {
        let registerContainer = try decoder.container(keyedBy: RegisterCodingKeys.self)
        
        id = try registerContainer.decode(Int.self, forKey: .id)
        firstname = try registerContainer.decode(String.self, forKey: .firstname)
        lastname = try registerContainer.decode(String.self, forKey: .lastname)
        email = try registerContainer.decode(String.self, forKey: .email)
        city = try registerContainer.decode(String.self, forKey: .city)
        birthday = try registerContainer.decode(Date.self, forKey: .birthday)
        sex = try registerContainer.decode(String.self, forKey: .sex)
    }
}


