//
//  LocationInfo.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

//struct LocationInfo: Codable {
//    var locationId: Int
//    var mobs: [MobsInLocation]
//    var mobNests: [MobNests]
//    var players: [PlayersInLocation]
//}

struct LocationInfo: Codable {
    var locationId: Int
    var mobs: [MobsInLocation]
    var mobNests: [MobNests]
    var players: [PlayersInLocation]
    
    private enum CodingKeys : String, CodingKey {
        case locationId = "1",
             players = "2",
             mobs = "3",
             mobNests = "4"
    }
}

struct PlayersInLocation: Codable {
    var id: Int
    var name: String
    var level: Int
    var classId: Int
    var state: Int
    
    private enum CodingKeys : String, CodingKey {
        case id = "1",
             name = "2",
             level = "3",
             classId = "4",
             state = "5"
    }
}

struct MobsInLocation: Codable {
}

struct MobNests: Codable {
    var amount: Int
    var id: Int
    var level: Int
    var mobClass: Int
    
    private enum CodingKeys : String, CodingKey {
        case id = "1",
             mobClass = "2",
             level = "3",
             amount = "4"
    }
}
