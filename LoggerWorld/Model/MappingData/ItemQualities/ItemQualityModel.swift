//
//  ItemQualitiesModel.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 01.01.2021.
//

import Foundation
import RealmSwift

class ItemQualityModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var code: ItemQualityValue.RawValue = ItemQualityValue.NONE.rawValue
    @objc dynamic var name: String = ""
    @objc dynamic var descr: String = ""
    
    convenience init(itemQuality: ItemQuality) {
        self.init()
        
        id = itemQuality.id
        code = itemQuality.code
        name = itemQuality.name
        descr = itemQuality.descr
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
