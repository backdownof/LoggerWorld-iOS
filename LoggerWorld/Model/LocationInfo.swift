//
//  LocationInfo.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

struct LocationInfo: Codable {
    var locationId: Int?
    var mobsInLocation: [MobsInLocation]?
    var playersInLocation: [PlayersInLocation]?
}

struct MobsInLocation: Codable {
}

struct PlayersInLocation: Codable {
    var classId: Int?
    var id: Int?
    var level: Int?
    var name: String?
}
