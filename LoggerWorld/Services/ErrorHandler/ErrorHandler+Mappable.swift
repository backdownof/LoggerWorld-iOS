//
//  ErrorHandler+Mappable.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import ObjectMapper

extension ErrorHandler {
    
    func mapping(map: Map) {
        message <- map[Key.message]
    }
    
}
