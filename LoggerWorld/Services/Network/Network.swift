//
//  Network.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 17.11.2020.
//

import UIKit
import Alamofire

class Network: NSObject {
    
    private enum Constants {
        static let headersJSON: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/json"),
            HTTPHeader(name: "Accept", value: "application/json")
        ]
        static let headersHTTP: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "application/x-www-form-urlencoded"),
            HTTPHeader(name: "Accept", value: "application/json")
        ]
        static let headersMultipart: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "multipart/form-data"),
            HTTPHeader(name: "Accept", value: "application/json")
        ]
    }
    
    // MARK: - Public properties
    
    static var isAvailableInternetConnection: Bool {
        return shared.reachabilityManager?.isReachable ?? false
    }
    
    // MARK: - Private properties
    
    private static let shared = Network()
    private let reachabilityManager = NetworkReachabilityManager()
    
    // MARK: - Public methods
    
    /**
     Creates a `DataOperation` using the default `SessionManager` to retrieve the contents of the specified `url`, `method`, `parameters`, `encoding` and `headers`.
     
     - parameter url: the URL
     - parameter method: the HTTP method
     - parameter parameters: the parameters
     - parameter success: returns the associated value if the result is a success, `nil` otherwise
     - parameter failure: returns `ErrorHandler` object
     
     - returns: the created `DataOperation`
     */
    @discardableResult
    static func request(url: URL?,
                        method: HTTPMethod,
                        parameters: [String : Any]?,
                        success: Constant.Block.data?,
                        failure: Constant.Block.error?) -> DataOperation? {
        
        guard let url = url else {
            failure?(.errorDefault)
            return nil
        }
        
        guard isAvailableInternetConnection else {
            failure?(.errorNoInternet)
            return nil
        }
        
        let encoding: ParameterEncoding = method == .get ? URLEncoding.queryString : JSONEncoding.default
        
        let request = AF
            .request(url,
                     method: method,
                     parameters: parameters,
                     encoding: encoding,
                     headers: handle(headers: Constants.headersJSON))
            .responseJSON { (response) in
                
                Network.handle(response,
                               success: success,
                               failure: failure)
        }
        
        return DataOperation(request: request)
    }
    
    // MARK: - Private methods
    
    /// Handles request headers.
    private static func handle(headers: HTTPHeaders) -> HTTPHeaders {
        var handledHeaders = headers
        if let token = User.token {
            let authorization: HTTPHeader = HTTPHeader(name: "Authorization", value: "Bearer " + token)
            handledHeaders.add(authorization)
        }
        let locale: HTTPHeader = HTTPHeader(name: "Locale", value: Locale.current.identifier.components(separatedBy: "_").first ?? "en")
        handledHeaders.add(locale)
        return handledHeaders
    }
    
    /**
     Handles request response.
     
     - parameter response: the response object `DataResponse`
     - parameter success: returns the associated value if the result is a success, `nil` otherwise
     - parameter failure: returns `ErrorHandler` object
     */
    private static func handle(_ response: AFDataResponse<Any>,
                               success: Constant.Block.data?,
                               failure: Constant.Block.error?) {
        print(response.response as Any)
        print(response.result)
        
        var errorHandler: ErrorHandler?
        if let error = ErrorHandler.error(response) {
            errorHandler = error
        } else if let error = response.error {
            errorHandler = ErrorHandler(error)
        }

        if let error = errorHandler, response.response?.statusCode != 200 {
            
            if error.isCancelled { return }

            if error.isNotAuthorized &&
                !(response.request?.url?.absoluteString ?? "").contains("logout") {
                
                User.logout()
//                UI.setRootController(R.storyboard.authorization.instantiateInitialViewController())
                print("user not authorized (Network.swift/handle(_ responce: ...)")
            }

            failure?(error)
            
        } else {
            success?(response.value)
        }
    }

}
