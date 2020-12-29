//
//  Players.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 24.11.2020.
//

import Foundation

struct CharactersMap: Codable {
    var players: [CharacterInformation]
}

struct CharacterInformation: Codable {
    var id: Int
    var userId: Int
    var name: String
    var classId: Int
    var locationId: Int
    var baseStats: BaseStats
    var effectiveStats: EffectiveStats
    var baseAttributes: BaseAttributes
    var effectiveAttributes: EffectiveAttributes
}


struct BaseStats: Codable {
    var hp: Double
    var mp: Double
    var id3: Double
    var id4: Double
    var id5: Double
    var id6: Double
    var id7: Double
    var lvl: Double
    
    private enum CodingKeys : String, CodingKey { case hp = "1",
                                                       mp = "2",
                                                       id3 = "3",
                                                       id4 = "4",
                                                       id5 = "5",
                                                       id6 = "6",
                                                       id7 = "7",
                                                       lvl = "8"
    }
}

struct EffectiveStats: Codable {
}

struct BaseAttributes: Codable {
    var id1: Double
    var id2: Double
    var id3: Double
    var id4: Double
    
    private enum CodingKeys : String, CodingKey { case id1 = "1",
                                                       id2 = "2",
                                                       id3 = "3",
                                                       id4 = "4"
    }
}

struct EffectiveAttributes: Codable {
}
