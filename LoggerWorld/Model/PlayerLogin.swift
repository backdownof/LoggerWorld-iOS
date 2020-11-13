//
//  PlayerLogin.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 03.11.2020.
//

import Foundation

public struct PlayerLogin: Codable {
    var command: String
    var args: Credentials
}
