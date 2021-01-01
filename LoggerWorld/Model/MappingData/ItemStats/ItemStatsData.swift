//
//  ItemStatsMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct ItemStatsData: Codable {
    var itemStats: [ItemStat]
}

struct ItemStat: Codable {
    var id: Int
    var code: ItemStatsValues.RawValue
    var name: String
    var descr: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id",
             code = "code",
             name = "name",
             descr = "description"
    }
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

