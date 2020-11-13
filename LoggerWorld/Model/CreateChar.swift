//
//  CreateChar.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 04.11.2020.
//

import Foundation

struct CreateChar: Codable {
    var command: String
    var args: Char
}

struct Char: Codable {
    var charName: String
    var className: String
}
