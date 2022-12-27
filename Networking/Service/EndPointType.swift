//
//  EndPointType.swift
//  OnWheels
//
//  Created by Veronika on 23.12.2022.
//

import Foundation
protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
