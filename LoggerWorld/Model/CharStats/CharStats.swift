//
//  CharacterAvailableStats.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 05.12.2020.
//

import Foundation

protocol CharStatsDelegate {
    func charStatsLoaded()
}

final class CharStats {
    static let shared = CharStats()
    
    var delegate: CharStatsDelegate?
    var stats: [StatMap] = []
    
    private init() {
        getAvailableStats()
    }
    
    private func getAvailableStats() {
        Network.getStatsDescription(completion: { stats in
            self.stats = stats
            self.delegate?.charStatsLoaded()
        }, failure: { error in
            print(error)
            self.delegate?.charStatsLoaded()
        })
    }
}
