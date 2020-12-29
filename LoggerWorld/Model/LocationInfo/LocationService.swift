//
//  LocationService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

protocol LocationServiceDelegate {
    func mapLoaded()
    func locationHasChanged()
}

extension LocationServiceDelegate {
    func mapLoaded() {}
    func locationHasChanged() {}
}

class LocationService {
    static let shared = LocationService()
    var delegate: LocationServiceDelegate?
    
    var locations: [LocationNameAndCoords]?
    var locationInfo: LocationInfo?
    var characterInMove: Bool?
    var playersInLocation: [PlayersInLocation]?
    var currentLocationName: String?
    
    private init() {
        getWorldMap()
        print("Location Service init")
        SocketManager.shared.locationDelegate = self
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
        return locationInfo!.players
    }
    
    private func getWorldMap() {
        Network.getLocationDict(completion: { locations in
            print("Map is loaded and saved")
            LocationService.shared.locations = locations
            self.delegate?.mapLoaded()
        }, failure: {
            print("Fucked up getting map")
            self.delegate?.mapLoaded()
        })
    }
}

extension LocationService: SocketManagerDelegate {
    func updatedLocationInfo(info: LocationInfo) {
        print("ff")
        let chars: [PlayersInLocation] = info.players
        var charsToDisplay: [PlayersInLocation] = []
        for char in chars {
            if char.state == 2 {
                if char.id == ActiveCharacter.shared.info.id {
                    charsToDisplay = [char]
                    LocationService.shared.playersInLocation = charsToDisplay
                    LocationService.shared.currentLocationName = "Вы в пути..."
                    delegate?.locationHasChanged()
                    LocationService.shared.locationInfo = info
                    LocationService.shared.characterInMove = true
                    return
                } else {
                    print("player with nickname \(char.name) moved out")
                }
            } else {
                charsToDisplay.append(char)
            }
        }
        
        playersInLocation = charsToDisplay
        LocationService.shared.locationInfo = info
        LocationService.shared.currentLocationName = LocationService.shared.getNameById(id: info.locationId)
        LocationService.shared.characterInMove = false
        delegate?.locationHasChanged()
    }
}
