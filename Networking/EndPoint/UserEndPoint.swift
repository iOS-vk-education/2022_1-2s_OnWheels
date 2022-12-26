//
//  UserEndPoint.swift
//  OnWheels
//
//  Created by Veronika on 24.12.2022.
//

import Foundation

enum UserEndPoint {
    case login(email: String, password: String)
    case register(surname: String,
                  name: String,
                  email: String,
                  password: String,
                  city: String,
                  birthday: String,
                  sex: Int)
    case userInfo(id: String)
    case currentUser
}

extension UserEndPoint: EndPointType {
    var enviromentslBaseUrl: String {
        switch NetworkManager.environment {
        case .qa:
            return "https://vpn.enula.ru/api/User"
        case .production:
            return "https://vpn.enula.ru/api/User"
        case .debug:
            return "https://vpn.enula.ru/api/User"
        }
    }
    var baseURL: URL {
        guard let url = URL(string: enviromentslBaseUrl) else {
            fatalError("Base url is invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return "/authorize"
        case .register:
            return ""
        case .userInfo(let id):
            return "/\(id)"
        case .currentUser:
            return "/current"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        case .userInfo:
            return .get
        case .currentUser:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case let .login(email: email, password: password):
            return .requestParameters(bodyParameters: ["email": email,
                                                       "password": password],
                                      urlParameters: nil)
        case let .register(surname:  surname,
                           name: name,
                           email: email,
                           password: password,
                           city: city,
                           birthday: birthday,
                           sex: sex):
            return .requestParameters(bodyParameters: ["firstname": name,
                                                       "lastname": surname,
                                                       "email": email,
                                                       "password": password,
                                                       "city": city,
                                                       "birthday": birthday,
                                                       "sex": sex],
                                      urlParameters: nil)

        case .userInfo(id: let id):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["id": id])
        case .currentUser:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
