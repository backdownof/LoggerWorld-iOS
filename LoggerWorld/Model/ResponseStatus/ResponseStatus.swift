//
//  ResponseStatus.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 02.12.2020.
//

import Foundation

struct ResponseStatus: Codable {
    var success: Bool?
    var message: String?
    var data: String?
}
