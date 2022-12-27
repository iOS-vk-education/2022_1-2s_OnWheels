//
//  NetworkManager.swift
//  OnWheels
//
//  Created by Veronika on 23.12.2022.
//

import Foundation

class NetworkManager {
    enum NetworkResponse: String {
        case success
        case authentificationError = "You need to be authentificated first"
        case badRequest = "Bad request"
        case outdated = "The url you requested is outdated"
        case failed = "Network request failed"
        case noData = "Response returned with no data to decode"
        case unableToDecode = "We could not decode the response"
    }

    enum Result<String> {
        case success
        case failure(String)
    }
    
    static let environment: NetworkEnvironment = .debug
    static let additionalHeader: HTTPHeaders = ["":""]

    func handleNetworkResponse(_ response : HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...499:
            return .failure(NetworkResponse.authentificationError.rawValue)
        case 501...599:
            return .failure(NetworkResponse.badRequest.rawValue)
        case 600:
            return .failure(NetworkResponse.outdated.rawValue)
        default:
            return .failure(NetworkResponse.failed.rawValue)
        }
    }

}

