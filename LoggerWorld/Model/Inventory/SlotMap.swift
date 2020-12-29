//
//  ItemStats.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 28.12.2020.
//

import Foundation

struct SlotMap: Codable {
    var id: Int
    var category: Int
    var quality: Int
    var quantity: Int
    var stats: ItemStats
    var stackable: Bool
    
    private enum CodingKeys: String, CodingKey {
        case id = "1",
             category = "2",
             quality = "3",
             quantity = "4",
             stats = "5",
             stackable = "6"
    }
}

struct ItemStats: Codable {
    var none: Int?
    var durability: Double?
    var maxDurability: Double?
    var usesPerDurability: Double?
    var weight: Double?
    var minDamage: Double?
    var maxDamage: Double?
    var armor: Double?
    var stackSize: Double?
    
    private enum CodingKeys: String, CodingKey {
        case none = "0",
             durability = "1",
             maxDurability = "2",
             usesPerDurability = "3",
             weight = "4",
             minDamage = "5",
             maxDamage = "6",
             armor = "7",
             stackSize = "8"
    }
}
