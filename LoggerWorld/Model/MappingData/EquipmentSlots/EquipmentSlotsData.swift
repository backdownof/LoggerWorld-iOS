//
//  EquipmentSlotsMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation

struct EquipmentSlotsData: Codable {
    var equipmentSlots: [EquipmentSlot]
}

struct EquipmentSlot: Codable {
    var id: Int
    var code: String
    var name: String
    var descr: String
    
    private enum CodingKeys: String, CodingKey {
        case id = "id",
             code = "code",
             name = "name",
             descr = "description"
    }
}
