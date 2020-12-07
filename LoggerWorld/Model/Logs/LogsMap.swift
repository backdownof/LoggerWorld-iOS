//
//  LogsMap.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 07.12.2020.
//

import Foundation

struct Logs: Codable {
    var entries: [LogMessage]
}

struct LogMessage: Codable {
    var dateTime: String
    var logClass: String
    var logType: String
    var message: String
}
