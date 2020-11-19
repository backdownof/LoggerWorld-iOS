//
//  ErrorHandler+Message.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation

extension ErrorHandler {
    
    enum Message {
        static let `default` = "Error"
        static let internetConnection = "Internet is down"
        static let notAuthorized = "You are not authorized"
    }
    
    // MARK: - Public properties
    
    static let errorDefault = ErrorHandler(ErrorHandler.Message.default)
    static let errorNoInternet: ErrorHandler = {
        let error = ErrorHandler(ErrorHandler.Message.internetConnection)
        error.statusCode = Constant.StatusCode.noInternetConnection
        return error
    }()
    static let errorNotAuthorized: ErrorHandler = {
        let error = ErrorHandler(ErrorHandler.Message.notAuthorized)
        error.statusCode = Constant.StatusCode.notAuthorized
        return error
    }()
    static let errorCancelled: ErrorHandler = {
        let error = ErrorHandler()
        error.statusCode = Constant.StatusCode.cancelled
        return error
    }()
    
}
