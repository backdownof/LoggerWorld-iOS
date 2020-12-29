//
//  ItemStatsMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct ItemStatsMap: Codable {
    var itemStats: [ItemStat]
}

struct ItemStat: Codable {
    var id: Int
    var code: ItemStatsValues.RawValue
    var name: String
    var description: String
}

enum ItemStatsValues: String {
    case NONE = "NONE"
    case DURABILITY = "DURABILITY"
    case MAX_DURABILITY = "MAX_DURABILITY"
    case USES_PER_DURABILITY = "USES_PER_DURABILITY"
    case WEIGHT = "WEIGHT"
    case MIN_DAMAGE = "MIN_DAMAGE"
    case MAX_DAMAGE = "MAX_DAMAGE"
    case ARMOR = "ARMOR"
    case STACK_SIZE = "STACK_SIZE"
}

