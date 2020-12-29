//
//  PlayingCharacter.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 04.12.2020.
//

import Foundation

protocol CharactersDelegate {
    func chardLoaded()
}

class Characters {
    static let shared = Characters()
    var delegate: CharactersDelegate?
    
    var characters: [CharacterInformation] = []
    
    private init() {
        loadData()
    }
    
    private func getAvailableCharacters() {
        Network.requestCharacters(completion: { chars in
            self.characters = chars
            self.delegate?.chardLoaded()
        }, failure: { message in
            print(message)
            self.delegate?.chardLoaded()
        })
    }
    
    func loadData() {
        getAvailableCharacters()
    }
}
