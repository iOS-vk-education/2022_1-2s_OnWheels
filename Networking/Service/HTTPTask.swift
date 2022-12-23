//
//  HTTPTask.swift
//  OnWheels
//
//  Created by Veronika on 23.12.2022.
//

import Foundation

public typealias HTTPHeaders = [String:String]
public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                           urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders)
   
}
