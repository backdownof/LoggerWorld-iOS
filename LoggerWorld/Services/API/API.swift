//
//  API.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 17.11.2020.
//

import Foundation

struct API {
    static let baseURL = "http://localhost:8080/"
}

extension API {
    
    struct Auth {
        /**
         Запрос на авторизацию
         
         - parameter success: возвращает ассоциированное значение, если результат успешный, иначе nil
         - parameter failure: возвращает объект `ErrorHandler`
         
         - returns: созданный `DataOperation`
         */
        @discardableResult
        static func login(userName: String,
                          password: String,
                          success: Constant.Block.data?,
                          failure: Constant.Block.error?) -> DataOperation? {
            
            return Network.request(url: (API.baseURL + "api/user/login").url,
                                   method: .post,
                                   parameters: [
                                    "userName" : userName,
                                    "password" : password
                                   ],
                                   success: success,
                                   failure: failure)
        }
    }
}
