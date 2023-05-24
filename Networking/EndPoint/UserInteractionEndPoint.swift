//
//  UserInteractionEndPoint.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation

enum UserInteractionEndPoint {
    case postLike(raceId: Int)
    case postView(raceId: Int)
    case deleteLike(raceId: Int)
    case postMember(raceId: Int)
    case getMember(raceId: Int)
    case deleteMember(raceId: Int)
}

extension UserInteractionEndPoint: EndPointType {
    var environmentBaseUrl: String {
        switch NetworkManager.environment {
        case .qa:
            return "https://onwheels.enula.ru/api/Race"
        case .production:
            return "https://onwheels.enula.ru/api/Race"
        case .debug:
            return "https://onwheels.enula.ru/api/Race"
        }
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseUrl) else {
            fatalError("Base url is invalid")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .postLike(let raceId):
            return "/\(raceId)/like"
        case .postView(let raceId):
            return "/\(raceId)/view"
        case .deleteLike(let raceId):
            return "/\(raceId)/like"
        case .postMember(raceId: let raceId):
            return "/\(raceId)/member"
        case .getMember(raceId: let raceId):
            return "/\(raceId)/member"
        case .deleteMember(raceId: let raceId):
            return "/\(raceId)/member"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .postLike(_):
            return .post
        case .postView(_):
            return .post
        case .deleteLike(_):
            return .delete
        case .postMember(raceId: _):
            return .post
        case .getMember(raceId: _):
            return .get
        case .deleteMember(raceId: _):
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .postView(_):
            return .request
        case .postLike(_):
            return .request
        case .deleteLike(_):
            return .request
        case .postMember(_):
            return .request
        case .getMember(_):
            return .request
        case .deleteMember(_):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
