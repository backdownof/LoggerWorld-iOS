//
//  InventoryMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 28.12.2020.
//

import Foundation

struct InventoryMap: Codable {
    var playerId: Int
    var maxSize: Int
    var slots: [SlotMap]
    
    private enum CodingKeys: String, CodingKey {
        case playerId = "1",
             maxSize = "2",
             slots = "3"
    }
}


