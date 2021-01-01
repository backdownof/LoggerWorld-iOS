//
//  EquipmentMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 28.12.2020.
//

import Foundation

struct EquipmentMap: Codable {
    var playerId: Int
    var slots: EquipmentSlotMap
    
    private enum CodingKeys: String, CodingKey {
        case playerId = "1",
             slots = "2"
    }
}

enum Slots: String {
    case NOTHING = "NOTHING"
    case HEAD = "HEAD"
    case AMULET = "AMULET"
    case LEFT_EARRING = "LEFT_EARRING"
    case RIGHT_EARRING = "RIGHT_EARRING"
    case BODY = "BODY"
    case LEFT_ARM = "LEFT_ARM"
    case RIGHT_ARM = "RIGHT_ARM"
    case GLOVES = "GLOVES"
    case LEFT_RING = "LEFT_RING"
    case RIGHT_RING = "RIGHT_RING"
    case QUIVER = "QUIVER"
    case BELT = "BELT"
    case PANTS = "PANTS"
    case BOOTS = "BOOTS"
}

struct EquipmentSlotMap: Codable {
    var head: SlotMap?
    var amulet: SlotMap?
    var leftEarring: SlotMap?
    var rightEarring: SlotMap?
    var body: SlotMap?
    var leftArm: SlotMap?
    var rightArm: SlotMap?
    var gloves: SlotMap?
    var leftRing: SlotMap?
    var rightRing: SlotMap?
    var quiver: SlotMap?
    var belt: SlotMap?
    var pants: SlotMap?
    var boots: SlotMap?
    
    private enum CodingKeys: String, CodingKey {
        case head = "1",
             amulet = "2",
             leftEarring = "3",
             rightEarring = "4",
             body = "5",
             leftArm = "6",
             rightArm = "7",
             gloves = "8",
             leftRing = "9",
             rightRing = "10",
             quiver = "11",
             belt = "12",
             pants = "13",
             boots = "14"
    }
}
