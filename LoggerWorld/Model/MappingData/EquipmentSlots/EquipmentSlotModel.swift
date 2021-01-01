//
//  EquipmentSlotModel.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 01.01.2021.
//

import Foundation
import RealmSwift

class EquipmentSlotModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var code: String = "NONE"
    @objc dynamic var name: String = ""
    @objc dynamic var descr: String = ""
    
    convenience init(equipmentSlot: EquipmentSlot) {
        self.init()
        
        id = equipmentSlot.id
        code = equipmentSlot.code
        name = equipmentSlot.name
        descr = equipmentSlot.descr
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
