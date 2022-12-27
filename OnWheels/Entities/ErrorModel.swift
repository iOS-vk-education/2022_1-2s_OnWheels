//
//  ErrorModel.swift
//  OnWheels
//
//  Created by Veronika on 25.12.2022.
//

import Foundation

struct ErrorModel {
    let message: String
}
extension ErrorModel {
    enum errorCodingKeys: String, CodingKey {
        case message = "Message"
    }
}
