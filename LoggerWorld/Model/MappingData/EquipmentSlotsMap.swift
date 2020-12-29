//
//  EquipmentSlotsMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct EquipmentSlotsMap: Codable {
    var equipmentSlots: [EquipmentSlot]
}

struct EquipmentSlot: Codable {
    var id: Int
    var code: Slots.RawValue
    var name: String
    var description: String
}
