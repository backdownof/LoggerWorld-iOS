//
//  User+Mappable.swift
//  Talk
//
//  Created by Гороховский Никита on 20.10.2020.
//  Copyright © 2020 PUMPIT. All rights reserved.
//

import ObjectMapper

extension User {
    
    func mapping(map: Map) {
        
        firstName <- map[Key.firstName]
        lastName <- map[Key.lastName]
        avatar <- map[Key.avatar]
        role <- map[Key.role]
        
        if let _ = try? map.value(Key.contacts) as [Contact] {
            contacts <- map[Key.contacts]
        }
    }
}
