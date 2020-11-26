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
}
