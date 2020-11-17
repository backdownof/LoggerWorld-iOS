//
//  User+Auth.swift
//  Talk
//
//  Created by Гороховский Никита on 20.10.2020.
//  Copyright © 2020 PUMPIT. All rights reserved.
//

import Foundation

extension User {
    
    // MARK: - Public methods
    
    /**
     Авторизация пользователя.
     
     
     - parameter completion: возвращает при успешном выполнении
     - parameter failure: возвращает объект `ErrorHandler`
     
     - returns: созданный `DataOperation`
     */
    @discardableResult
    static func login(phone: String,
                      token: String,
                      completion: Constant.Block.completion?,
                      failure: Constant.Block.error?) -> DataOperation? {
        
        return API.Auth.login(phone: phone,
                              token: token,
                              success: { (json) in
                                User.saveToken(json: json,
                                               completion: completion,
                                               failure: failure)
                              },
                              failure: failure)
    }
    
    /**
     Выход из аккаунта пользователя.
     
     - parameter completion: возвращается в конце операции
     
     - returns: созданный `DataOperation`
     */
    
    static func logout() {
        
    }
    
    // MARK: - Private methods
    
    private static func saveToken(json: Any?,
                                  completion: Constant.Block.completion?,
                                  failure: Constant.Block.error?) {
        if let token = (json as? [String: Any])?["token"] as? String {
            User.token = token
            completion?()
        } else {
            failure?(ErrorHandler("Ошибка при получении токена"))
        }
    }
}
