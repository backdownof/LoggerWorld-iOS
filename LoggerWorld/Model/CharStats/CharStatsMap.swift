//
//  CharStatsMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 05.12.2020.
//

import Foundation

struct CharStatsMap: Codable {
    var stats: [StatMap]
}

struct StatMap: Codable {
    var id: Int
    var code: String
    var name: String
    var description: String
}
