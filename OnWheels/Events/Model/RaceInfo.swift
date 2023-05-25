//
//  RaceInfo.swift
//  OnWheels
//
//  Created by Veronika on 23.05.2023.
//

import Foundation
struct RaceInfo: Hashable {
    let id: Int
    let title: String
    let dateSubtitle: String
    let imageId: String
    var numberOfLikes: Int
    var numberOfParticipants: Int
    var numberOfWatchers: Int
    var isLiked: Bool
    let tags: [String]
}
