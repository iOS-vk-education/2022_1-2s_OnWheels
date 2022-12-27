//
//  UserModel.swift
//  OnWheels
//
//  Created by Veronika on 24.12.2022.
//

import Foundation

struct Login: Codable {
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

struct Register: Codable {
    let firstname: String
    let lastname: String
    let email: String
    let password: String
    let city: String
    let birthday: String
    let sex: Int
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
        birthday = try registerContainer.decode(String.self, forKey: .birthday)
        sex = try registerContainer.decode(Int.self, forKey: .sex)
    }
}

struct UserInfo: Codable {
    let id: Int
    let firstname: String
    let lastname: String
    let email: String
    let sex: String
    let city: String
    let birthday: String
}
extension UserInfo {
    enum UserCodingKeys: CodingKey {
        case id
        case firstname
        case lastname
        case email
        case city
        case birthday
        case sex
    }
    
    init(from decoder: Decoder) throws {
        let userContainer = try decoder.container(keyedBy: UserCodingKeys.self)
        
        id = try userContainer.decode(Int.self, forKey: .id)
        firstname = try userContainer.decode(String.self, forKey: .firstname)
        lastname = try userContainer.decode(String.self, forKey: .lastname)
        email = try userContainer.decode(String.self, forKey: .email)
        city = try userContainer.decode(String.self, forKey: .city)
        birthday = try userContainer.decode(String.self, forKey: .birthday)
        sex = try userContainer.decode(String.self, forKey: .sex)
    }
}

struct CurrentUser: Codable {
    let id: Int
    let firstname, lastname, email, city: String
    let birthday: String
    let sex: String
}

extension CurrentUser {
    enum CurrentCodingKeys: CodingKey {
        case id
        case firstname
        case lastname
        case email
        case city
        case birthday
        case sex
    }
    
    init(from decoder: Decoder) throws {
        let currentContainer = try decoder.container(keyedBy: CurrentCodingKeys.self)
        
        id = try currentContainer.decode(Int.self, forKey: .id)
        firstname = try currentContainer.decode(String.self, forKey: .firstname)
        lastname = try currentContainer.decode(String.self, forKey: .lastname)
        email = try currentContainer.decode(String.self, forKey: .email)
        city = try currentContainer.decode(String.self, forKey: .city)
        birthday = try currentContainer.decode(String.self, forKey: .birthday)
        sex = try currentContainer.decode(String.self, forKey: .sex)
    }
}
