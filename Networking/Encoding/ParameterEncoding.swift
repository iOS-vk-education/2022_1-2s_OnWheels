//
//  ParameterEncoding.swift
//  OnWheels
//
//  Created by Veronika on 23.12.2022.
//

import Foundation

public typealias Parameters = [String:Any]


public protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters are nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
