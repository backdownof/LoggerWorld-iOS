//
//  MessageMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 09.12.2020.
//

import Foundation

struct MessageMap: Codable {
    var dateTime: String
    var logClass: String
    var logType: String
    var message: String
}
