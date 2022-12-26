//
//  RaceEndPoint.swift
//  OnWheels
//
//  Created by Veronika on 25.12.2022.
//
import Foundation

enum RaceEndPoint {
    case getAllRaces
    case getRace(raceId: Int)
}

extension RaceEndPoint: EndPointType {
    var enviromentslBaseUrl: String {
        switch NetworkManager.environment {
        case .qa:
            return "https://vpn.enula.ru/api/Race"
        case .production:
            return "https://vpn.enula.ru/api/Race"
        case .debug:
            return "https://vpn.enula.ru/api/Race"
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
        case .getAllRaces:
            return "/filter"
        case .getRace(let raceId):
            return "/\(raceId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getAllRaces:
            return .get
        case .getRace(raceId: _):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getAllRaces:
            return .requestParameters(bodyParameters: ["":""],
                                                urlParameters: nil)
        case .getRace(_):
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
