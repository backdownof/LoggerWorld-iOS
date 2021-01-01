//
//  MapsService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 29.12.2020.
//

import Foundation
import RealmSwift

class MapsService {
    static func loadAllMaps(complition: @escaping() -> Void, failure: @escaping() -> Void) {
        var mapsLoadedCount: Int = 0
        var mapServiceError: Bool = false
        
        let realm = try! Realm()
        
        Network.getItemCategoriesMap(completion: { itemCategories in
            for item in itemCategories {
                let itemCategory = ItemCategoryModel(itemCategoryData: item)
                try! realm.write {
                    realm.add(itemCategory, update: .all)
                }
            }
            mapLoaded()
        }, failure: {
            mapServiceError = true
        })
        
        Network.getEquipmentSlotsMap(completion: { response in
            for slot in response {
                let slotModel = EquipmentSlotModel(equipmentSlot: slot)
                try! realm.write {
                    realm.add(slotModel, update: .all)
                }
            }
            mapLoaded()
        }, failure: {
            mapServiceError = true
        })
        
        Network.getItemQualitiesMap(completion: { response in
            for item in response {
                let itemQuality = ItemQualityModel(itemQuality: item)
                try! realm.write {
                    realm.add(itemQuality, update: .all)
                }
            }
            mapLoaded()
        }, failure: {
            mapServiceError = true
        })
        
        Network.getItemStatsMap(completion: { response in
            for item in response {
                let itemStat = ItemStatModel(itemStat: item)
                try! realm.write {
                    realm.add(itemStat, update: .all)
                }
            }
            mapLoaded()
        }, failure: {
            mapServiceError = true
        })
        
        Network.getLocationDict(completion: { response in
            for location in response {
                let location = WorldMapModel(locationMapData: location)
                try! realm.write {
                    realm.add(location, update: .all)
                }
            }
            mapLoaded()
        }, failure: {
            mapServiceError = true
        })
        
        func mapLoaded() {
            mapsLoadedCount += 1
            if mapsLoadedCount == 5 && !mapServiceError {
                complition()
            } else {
                failure()
            }
        }
    }
}
