//
//  ItemQualitiesMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct ItemQualitiesData: Codable {
    var itemQualities: [ItemQuality]
}

struct ItemQuality: Codable {
    var id: Int
    var code: ItemQualityValue.RawValue
    var name: String
    var descr: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id",
             code = "code",
             name = "name",
             descr = "description"
    }
}

enum ItemQualityValue: String {
    case NONE = "NONE"
    case COMMON = "COMMON"
    case GOOD = "GOOD"
    case RARE = "RARE"
    case EPIC = "EPIC"
    case LEGENDARY = "LEGENDARY"
}
