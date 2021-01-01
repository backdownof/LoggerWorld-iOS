//
//  ItemCategories.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 31.12.2020.
//

import Foundation
import RealmSwift

class ItemCategoryModel: Object {
    @objc dynamic var id: Int = 0
    let parentId = RealmOptional<Int>()
    @objc dynamic var isItem: Bool = false
    @objc dynamic var code: ItemCode.RawValue = ItemCode.NOTHING.rawValue
    @objc dynamic var name: String = ""
    @objc dynamic var descr: String = ""
    var stats = List<Int>()
    var equipmentSlots = List<Int>()
    
    convenience init(itemCategoryData: ItemCategoryData) {
        self.init()
        id = itemCategoryData.id
        parentId.value = itemCategoryData.parentId
        isItem = itemCategoryData.isItem
        code = itemCategoryData.code
        name = itemCategoryData.name
        descr = itemCategoryData.descr
        for stat in itemCategoryData.stats {
            stats.append(stat)
        }
        for category in itemCategoryData.equipmentSlots {
            equipmentSlots.append(category)
        }
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
