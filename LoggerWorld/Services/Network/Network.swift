//
//  Network.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation
import Alamofire

class Network: NSObject {
    
    static var isAvailableInternetConnection: Bool {
        return shared.reachabilityManager?.isReachable ?? false
    }
    
    private static let shared = Network()
    private let reachabilityManager = NetworkReachabilityManager()
    
    static func requestLogin(userName: String,
                             password: String,
                             completion: @escaping () -> Void,
                             failure: @escaping () -> ()) {
        let parameters: [String: Any] = [
            "userName" : userName,
            "password": password
        ]
        
        AF.request((API.baseURL + "api/user/login").url as! URLConvertible,
                   method: .post, parameters: parameters,
                   encoding: JSONEncoding.default).responseJSON { response in
                    print(response.response?.statusCode)
                    guard let status = response.response?.statusCode else { return }
                    if Array(200...201).contains(status)  {
                        
                        if let headers = response.response?.allHeaderFields as? [String: String] {
                            let header = headers["Authorization"]
                            guard let authHeader = header else { return }
                            print(3)
                            if authHeader.contains("Bearer "){
                                print(2)
                                let regex = try! NSRegularExpression(pattern: #"^(.*?)\s*Bearer\s*(.*)$"#, options: .caseInsensitive)
                                if let match = regex.firstMatch(in: authHeader, range: NSRange(authHeader.startIndex..., in: authHeader)) {
                                    let token = authHeader[Range(match.range(at: 2), in: authHeader)!]
                                    User.token = String(token)
                                    completion()
                                } else {
                                    failure()
                                }
                            }
                            
                        } else {
                            failure()
                        }
                    }
                   }
    }
    
    
    static func requestRegister(userName: String,
                                password: String,
                                language: String? = "RU",
                                displayName: String? = nil,
                                email: String,
                                completion: @escaping () -> Void,
                                failure: @escaping() -> Void) {
        AF.request((API.baseURL + "api/user/sign-up").url as! URLConvertible,
                   method: .post,
                   parameters: [
                    "userName": userName,
                    "password": password,
                    "language": language,
                    "displayName": userName,
                    "email": email
                   ],
                   encoding: JSONEncoding.default).responseJSON(completionHandler: { response in
                    guard let status = response.response?.statusCode else { return }
                    if Array(200...201).contains(status)  {
                        completion()
                    } else {
                        failure()
                    }
                    
                   })
    }
}
