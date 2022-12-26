//
//  RaceModel.swift
//  OnWheels
//
//  Created by Veronika on 25.12.2022.
//

import Foundation

struct RaceResponse {
    let races: [Race]
}
extension RaceResponse: Decodable {
    private enum RaceResponseCodingKeys: CodingKey{
        case races
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RaceResponseCodingKeys.self)
        races = try container.decode([Race].self, forKey: .races)
    }
}

struct Race: Codable {
    let name: String
    let location: Location
    let date: DateClass
    let racesDescription: String
    let imageUrls, tags: [String]

    enum RacesCodingKeys: String, CodingKey {
        case name, location, date
        case racesDescription = "description"
        case imageUrls, tags
    }
}

extension Race {
    init(from decoder: Decoder) throws {
        let racesContainer = try decoder.container(keyedBy: RacesCodingKeys.self)
        name = try racesContainer.decode(String.self, forKey: .name)
        location = try racesContainer.decode(Location.self, forKey: .location)
        date = try racesContainer.decode(DateClass.self, forKey: .date)
        racesDescription = try racesContainer.decode(String.self, forKey: .racesDescription)
        imageUrls = try racesContainer.decode([String].self, forKey: .imageUrls)
        tags = try racesContainer.decode([String].self, forKey: .tags)
    }
}

struct OneRace: Codable {
    let creatorUserID: Int
    let name: String
    let location: Location
    let date: DateClass
    let oneRaceDescription: String
    let images, tags: [String]
    let members: [Int]
    let likes, views: Int

    enum OneRaceCodingKeys: String, CodingKey {
        case creatorUserID = "creatorUserId"
        case name, location, date
        case oneRaceDescription = "description"
        case images, tags, members, likes, views
    }
}

extension OneRace {
    init(from decoder: Decoder) throws {
        let oneRaceContainer = try decoder.container(keyedBy: OneRaceCodingKeys.self)
        creatorUserID = try oneRaceContainer.decode(Int.self, forKey: .creatorUserID)
        name = try oneRaceContainer.decode(String.self, forKey: .name)
        location = try oneRaceContainer.decode(Location.self, forKey: .location)
        date = try oneRaceContainer.decode(DateClass.self, forKey: .date)
        oneRaceDescription = try oneRaceContainer.decode(String.self, forKey: .oneRaceDescription)
        images = try oneRaceContainer.decode([String].self, forKey: .images)
        tags = try oneRaceContainer.decode([String].self, forKey: .tags)
        members = try oneRaceContainer.decode([Int].self, forKey: .members)
        likes = try oneRaceContainer.decode(Int.self, forKey: .likes)
        views = try oneRaceContainer.decode(Int.self, forKey: .views)
    }
}

// MARK: - DateClass
struct DateClass: Codable {
    let from, to: String
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: Int
}
