//
//  ItemCategories.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct ItemCategoriesData: Codable {
    var itemCategories: [ItemCategoryData]
}

struct ItemCategoryData: Codable {
    var id: Int
    var parentId: Int?
    var isItem: Bool
    var code: ItemCode.RawValue
    var name: String
    var descr: String
    var stats: [Int]
    var equipmentSlots: [Int]
    
    private enum CodingKeys: String, CodingKey {
        case descr = "description",
             id = "id",
             parentId = "parentId",
             isItem = "isItem",
             code = "code",
             name = "name",
             stats = "stats",
             equipmentSlots = "equipmentSlots"
        
    }
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
