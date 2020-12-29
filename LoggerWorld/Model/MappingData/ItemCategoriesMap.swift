//
//  ItemCategories.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct ItemCategoriesMap: Codable {
    var itemCategories: [ItemCategory]
}

struct ItemCategory: Codable {
    var id: Int
    var parentId: Int?
    var isItem: Bool
    var code: ItemCode.RawValue
    var name: String
    var description: String
    var stats: [Int]
    var equipmentSlots: [Int]
}

enum ItemCode: String {
    case NOTHING = "NOTHING"
    case VALUABLES = "VALUABLES"
    case WEAPON = "WEAPON"
    case ARMOR = "ARMOR"
    case CONSUMABLE = "CONSUMABLE"
    case GOLD = "GOLD"
    case MELEE = "MELEE"
    case ONE_HANDED = "ONE_HANDED"
    case SWORD = "SWORD"
    case SHORT_SWORD = "SHORT_SWORD"
}
