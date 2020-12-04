//
//  Players.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 24.11.2020.
//

import Foundation

struct Players: Codable {
    var players: [CharListToLogin]?
}

struct CharListToLogin: Codable {
    var id: Int?
    var userId: Int?
    var name: String?
    var classId: Int?
    var locationId: Int?
    var stats: PlayerStats?
}


struct PlayerStats: Codable {
    var id1: Double?
    var id2: Double?
    var id3: Double?
    var id4: Double?
    var id5: Double?
    var id6: Double?
    var id7: Double?
    var id8: Double?
    var id9: Double?
    var id10: Double?
    var id11: Double?
    var id12: Double?
    var id13: Double?
    var id14: Double?

    private enum CodingKeys : String, CodingKey { case id1 = "1",
                                                       id2 = "2",
                                                       id3 = "3",
                                                       id4 = "4",
                                                       id5 = "5",
                                                       id6 = "6",
                                                       id7 = "7",
                                                       id8 = "8",
                                                       id9 = "9",
                                                       id10 = "10",
                                                       id11 = "11",
                                                       id12 = "12",
                                                       id13 = "13",
                                                       id14 = "14"}
}
