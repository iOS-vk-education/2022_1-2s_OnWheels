//
//  ImageEndPoint.swift
//  OnWheels
//
//  Created by Veronika on 21.05.2023.
//

import Foundation

enum ImageEndPoint {
    case postImage(image: Data)
}

extension ImageEndPoint: EndPointType {
    var enviromentslBaseUrl: String {
        switch NetworkManager.environment {
        case .qa:
            return "https://onwheels.enula.ru/api/Image"
        case .production:
            return "https://onwheels.enula.ru/api/Image"
        case .debug:
            return "https://onwheels.enula.ru/api/Image"
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
        case .postImage:
            return ""
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .postImage:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .postImage(let data):
            return .uploadImage(image: data)
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
