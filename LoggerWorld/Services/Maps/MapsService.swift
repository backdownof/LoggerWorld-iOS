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
        
        
        let realm = try! Realm()
        
        Network.getItemCategoriesMap(completion: { itemCategories in
            for item in itemCategories {
                let itemCategory = ItemCategory(itemCategoryData: item)
                try! realm.write {
                    realm.add(itemCategory)
                }
            }
            complition()
        }, failure: {
            
        })
        
        Network.getEquipmentSlotsMap(completion: { response in
            
        }, failure: {
            
        })
        
        Network.getItemQualitiesMap(completion: { response in
            
        }, failure: {
            
        })
        
        Network.getItemStatsMap(completion: { response in
            
        }, failure: {
            
        })
    }
}
