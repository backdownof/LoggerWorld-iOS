//
//  Logger.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 27.12.2020.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    static let apiRequest = Logger(subsystem: subsystem, category: "apirequest")
    static let stompSent = Logger(subsystem: subsystem, category: "stompsent")
    static let stompRecieved = Logger(subsystem: subsystem, category: "stomprecieved")
}
