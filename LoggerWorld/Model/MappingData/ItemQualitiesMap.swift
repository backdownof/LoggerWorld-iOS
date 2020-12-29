//
//  ItemQualitiesMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct ItemQualitiesMap: Codable {
    var itemQualities: [ItemQuality]
}

struct ItemQuality: Codable {
    var id: Int
    var code: Quality.RawValue
    var name: String
    var description: String
}

enum Quality: String {
    case NONE = "NONE"
    case COMMON = "COMMON"
    case GOOD = "GOOD"
    case RARE = "RARE"
    case EPIC = "EPIC"
    case LEGENDARY = "LEGENDARY"
}
