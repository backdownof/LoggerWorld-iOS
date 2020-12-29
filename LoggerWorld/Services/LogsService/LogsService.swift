//
//  LogsService.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 27.12.2020.
//

import Foundation

protocol NewLogDelegate {
    func logReceived(message: LogMessage)
}

class LogService: LogsDelegate {
    var logDelegate: NewLogDelegate?

    
    func messageReceived(log: LogMessage) {
        logDelegate?.logReceived(message: log)
    }
    
    func prepareMessage(log: LogMessage) -> String {
        return "\(log.logClass) \(log.message)"
    }
}
