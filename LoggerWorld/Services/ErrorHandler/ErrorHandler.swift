//
//  ErrorHandler.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import UIKit
import Alamofire
import ObjectMapper

class ErrorHandler: NSObject, Error, Mappable {

    // MARK: - Public properties

    var message: String = ErrorHandler.Message.default
    var statusCode: Int = 0
    var isCancelled: Bool {
        return statusCode == Constant.StatusCode.cancelled
    }
    var isNotInternetConnection: Bool {
        return statusCode == Constant.StatusCode.noInternetConnection
    }
    var isNotAuthorized: Bool {
        return statusCode == Constant.StatusCode.notAuthorized
    }

    // MARK: - Public methods

//    static func error(_ response: DataResponse<Any>) -> ErrorHandler? {
//
//        if response.response?.statusCode == 200 {
//            return nil
//        }
//
//        guard let json = response.result.value as? [String : Any],
//            let error = Mapper<ErrorHandler>().map(JSON: json),
//            error.message != ErrorHandler.Message.default else { return nil }
//
//        error.statusCode = response.response?.statusCode ?? 0
//
//        return error
//    }
    
    static func error(_ response: AFDataResponse<Any>) -> ErrorHandler? {
        
        if response.response?.statusCode == 200 {
            return nil
        }
        
        guard let json = response.value as? [String : Any],
            let error = Mapper<ErrorHandler>().map(JSON: json),
            error.message != ErrorHandler.Message.default else { return nil }
        
        error.statusCode = response.response?.statusCode ?? 0
        
        return error
    }

    // MARK: - Init

    override init() { super.init() }

    init(_ message: String) {
        self.message = message
        super.init()
    }

    init(_ error: Error) {
        self.message = error.localizedDescription
        self.statusCode = (error as NSError?)?.code ?? 0
        super.init()
        if self.isNotInternetConnection {
            self.message = ErrorHandler.Message.internetConnection
        }
    }

    // MARK: - Mappable

    required init?(map: Map) { super.init() }

}

