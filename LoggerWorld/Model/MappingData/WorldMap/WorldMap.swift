//
//  WorldMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import Foundation

struct WorldMap: Codable {
    var locations: [LocationMapData]?
}

struct LocationMapData: Codable {
    var id: Int
    var typeId: Int
    var name: String
    var descr: String
    var xcoord: Int
    var ycoord: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "id",
             typeId = "typeId",
             name = "name",
             descr = "description",
             xcoord = "xcoord",
             ycoord = "ycoord"
    }
}
