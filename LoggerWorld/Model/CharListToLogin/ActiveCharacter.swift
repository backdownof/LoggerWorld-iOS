//
//  ActiveCharacter.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 05.12.2020.
//

import Foundation

class ActiveCharacter {
    static let shared = ActiveCharacter()
    
    var info: CharacterInformation!
    
    struct Config {
        var id: Int
    }
    
    private static var config:Config?

    class func setup(_ config:Config){
        ActiveCharacter.config = config
    }

    private init() {
        guard ActiveCharacter.config != nil else {
            fatalError("Error - you must call setup before accessing MySingleton.shared")
        }

        for character in Characters.shared.characters {
            if character.id == ActiveCharacter.config!.id {
                info = character
            }
        }
    }
    
}
