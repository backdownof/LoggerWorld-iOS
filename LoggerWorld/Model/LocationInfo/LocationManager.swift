//
//  LocationService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation
import RealmSwift

protocol LocationServiceDelegate {
    func locationHasChanged()
}

extension LocationServiceDelegate {
    func locationHasChanged() {}
}

class LocationManager {
    static let shared = LocationManager()
    var delegate: LocationServiceDelegate?
    
    var locations: [LocationMapData]?
    var locationInfo: LocationInfo?
    var characterInMove: Bool?
    var playersInLocation: [PlayersInLocation]?
    let realm = try! Realm()
    
    private init() {
        SocketManager.shared.locationDelegate = self
    }
    
    func getNameById(id: Int) -> String {
        let location = realm.objects(WorldMapModel.self).filter("id == \(id)").first
        guard let locName = location?.name else { return "Default" }
        
        return locName
    }
    
    func getCharsInLocation() -> [PlayersInLocation] {
        return locationInfo!.players
    }
    
    func getCurrentLocationName() -> String {
        if let currentLocId = locationInfo?.locationId {
            return getNameById(id: currentLocId)
        } else {
            return "Ошибка..."
        }
    }
    
    func getWorldMap() -> ([WorldMapModel], Int, Int) {
        var mapLocations: [WorldMapModel] = []
        
        var maxXcoord = 0
        var maxYcoord = 0
        
        let locations = realm.objects(WorldMapModel.self)
        
        for location in locations {
            maxXcoord = (location.xcoord > maxXcoord) ? location.xcoord : maxXcoord
            maxYcoord = (location.ycoord > maxYcoord) ? location.ycoord : maxYcoord
        }
        maxYcoord += 1
        maxXcoord += 1
        
        for x in 0...maxXcoord {
            for y in 0...maxYcoord {
                for loc in locations {
                    if loc.xcoord == x && loc.ycoord == y {
                        mapLocations.append(loc)
                    }
                }
            }
        }
        
        return (mapLocations, maxXcoord, maxYcoord)
    }
}

extension LocationManager: SocketManagerDelegate {
    func updatedLocationInfo(info: LocationInfo) {
        let chars: [PlayersInLocation] = info.players
        var charsToDisplay: [PlayersInLocation] = []
        for char in chars {
            if char.state == 2 {
                if char.id == ActiveCharacter.shared.info.id {
                    charsToDisplay = [char]
                    LocationManager.shared.playersInLocation = charsToDisplay
                    delegate?.locationHasChanged()
                    LocationManager.shared.locationInfo = info
                    LocationManager.shared.characterInMove = true
                    return
                } else {
                    print("player with nickname \(char.name) moved out")
                }
            } else {
                charsToDisplay.append(char)
            }
        }
        
        playersInLocation = charsToDisplay
        LocationManager.shared.locationInfo = info
        LocationManager.shared.characterInMove = false
        delegate?.locationHasChanged()
    }
}
