//
//  WorldMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

struct WorldMap: Codable {
    var locations: [LocationNameAndCoords]?
}

struct LocationNameAndCoords: Codable {
    var id: Int?
    var typeId: Int?
    var name: String?
    var description: String?
    var xcoord: Int?
    var ycoord: Int?
}
