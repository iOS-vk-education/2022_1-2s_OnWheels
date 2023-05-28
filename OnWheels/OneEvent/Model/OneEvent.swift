//
//  OneEvent.swift
//  OnWheels
//
//  Created by Veronika on 26.05.2023.
//

import Foundation
struct OneEvent: Hashable {
    let title: String
    let dateSubtitle: String
    let latitude: Double
    let longitude: Double
    let placeName: String
    let imageId: String
    let description: String
    let tags: [String]
    var isMember: Bool
}
