//
//  ItemStatsModel.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 01.01.2021.
//

import Foundation
import RealmSwift

class ItemStatModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var code: ItemStatsValues.RawValue = ItemStatsValues.NONE.rawValue
    @objc dynamic var name: String = ""
    @objc dynamic var descr: String = ""
    
    convenience init(itemStat: ItemStat) {
        self.init()
        
        id = itemStat.id
        code = itemStat.code
        name = itemStat.name
        descr = itemStat.descr
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
