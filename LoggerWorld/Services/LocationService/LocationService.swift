//
//  LocationService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

class LocationService {
    static let shared = LocationService()
    
    var locations: [LocationNameAndCoords]?
    var locationInfo: LocationInfo?
    var currentLocationId: Int?
    
    func getNameById(id: Int) -> String {
        guard let locs = locations else { return "Default" }
        for loc in locs {
            if loc.id == id {
                guard let locName = loc.name else { return "Location \(loc.id)" }
                return locName
            }
        }
        return "Default"
    }
    
    func getCharsInLocation() -> [PlayersInLocation] {
        guard let players = locationInfo?.players else { return [PlayersInLocation()] }
        return players
    }
}
