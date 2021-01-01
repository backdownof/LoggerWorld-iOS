//
//  WorldMapModel.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 01.01.2021.
//

import Foundation
import RealmSwift

class WorldMapModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var typeId: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var descr: String = ""
    @objc dynamic var xcoord: Int = 0
    @objc dynamic var ycoord: Int = 0
    
    convenience init(locationMapData: LocationMapData) {
        self.init()
        
        id = locationMapData.id
        typeId = locationMapData.typeId
        name = locationMapData.name
        descr = locationMapData.descr
        xcoord = locationMapData.xcoord
        ycoord = locationMapData.ycoord
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
