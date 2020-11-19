//
//  User.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation

class User: NSObject {
    
    
}

extension User {
    // MARK: - Public properties
    
    static var isAuthorized: Bool {
        return token != nil
    }
    
    static var token: String? {
        get {
            return UserSettings.token
        }
        set {
            UserSettings.token = newValue
        }
    }
    
//    static var current: User? {
//        get {
//            return UserSettings.user
//        }
//        set {
//            UserSettings.user = newValue
//            NotificationCenter.default.post(name: .didChangeUser, object: nil)
//        }
//    }
}

extension User {
    
    // MARK: - Public methods
    
    /**
     Авторизация пользователя.
     
     
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает объект `ErrorHandler`
     
     - returns: созданный `DataOperation`
     */
//    @discardableResult
//    static func login(phone: String,
//                      token: String,
//                      completion: Constant.Block.completion?,
//                      failure: Constant.Block.error?) -> DataOperation? {
//
//        return API.Auth.login(phone: phone,
//                              token: token,
//                              success: { (json) in
//                                User.saveToken(json: json,
//                                               completion: completion,
//                                               failure: failure)
//                              },
//                              failure: failure)
//    }
    
    /**
     Выход из аккаунта пользователя.
     
     - parameter completion: возвращается в конце операции
     
     - returns: созданный `DataOperation`
     */
    
    static func logout() {
        
    }
    
    // MARK: - Private methods
    
//    private static func saveToken(json: Any?,
//                                  completion: Constant.Block.completion?,
//                                  failure: Constant.Block.error?) {
//        if let token = (json as? [String: Any])?["token"] as? String {
//            User.token = token
//            completion?()
//        } else {
////            failure?(ErrorHandler("Ошибка при получении токена"))
//            print("Ошибка при получении токена")
//        }
//    }
}

extension User {
    
    // MARK: - Public methods
    
//    @discardableResult
//    static func profile(completion: Constant.Block.completion? = nil,
//                        failure: Constant.Block.error? = nil) -> DataOperation? {
//        return API.User.profile(success: { (json) in
//
//            User.readAndSaveProfile(
//                json: json,
//                completion: completion,
//                failure: failure
//            )
//        }, failure: failure)
//    }
    
    // MARK: - Private methods
    
//    private static func readAndSaveProfile(json: Any?,
//                                            completion: Constant.Block.completion?,
//                                            failure: Constant.Block.error?) {
//        Parser.parse(json: json,
//                     mappable: User.self,
//                     success: { (data) in
//
//                        if let user = data as? User {
//                            User.current = user
//                            completion?()
//
//                        } else {
//                            failure?(Parser.error)
//                        }
//                     },
//                     failure: failure)
//    }
}
