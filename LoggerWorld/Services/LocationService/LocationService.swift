//
//  LocationService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

protocol WorldMapDelegate {
    func mapLoaded()
}

class LocationService {
    static let shared = LocationService()
    var delegate: WorldMapDelegate?
    
    var locations: [LocationNameAndCoords]?
    var locationInfo: LocationInfo?
    var currentLocationId: Int?
    
    private init() {
        getWorldMap()
    }
    
    func getNameById(id: Int) -> String {
        guard let locs = locations else { return "Default" }
        for loc in locs {
            if loc.id == id {
                guard let locName = loc.name else { return "Location \(String(describing: loc.id))" }
                return locName
            }
        }
        return "Default"
    }
    
    func getCharsInLocation() -> [PlayersInLocation] {
        guard let players = locationInfo?.players else { return [PlayersInLocation()] }
        return players
    }
    
    private func getWorldMap() {
        Network.getLocationDict(completion: { locations in
            LocationService.shared.locations = locations
            self.delegate?.mapLoaded()
        }, failure: {
            print("Fucked up getting map")
            self.delegate?.mapLoaded()
        })
    }
}
