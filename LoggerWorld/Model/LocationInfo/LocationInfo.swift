//
//  LocationInfo.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

struct LocationInfo: Codable {
    var locationId: Int
    var mobs: [MobsInLocation]
    var mobNests: [MobNests]
    var players: [PlayersInLocation]
}

struct MobNests: Codable {
    var amount: Int
    var id: Int
    var level: Int
    var mobClass: String
}

struct MobsInLocation: Codable {
    
}

struct PlayersInLocation: Codable {
    var classId: Int
    var id: Int
    var level: Int
    var state: String
    var name: String
}
