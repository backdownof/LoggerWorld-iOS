//
//  API+Registration.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 17.11.2020.
//

import Foundation

extension API {
    struct Registration {
        /**
        - parameter token: Токен запрашиваемый для авторизованного пользователя
         */
        
        @discardableResult
        static func registrate(userName: String,
                               email: String,
                               password: String,
                               success: Constant.Block.data?,
                               failure: Constant.Block.error?) -> DataOperation? {
            
            return Network.request(url: (API.baseURL + "api/user/sign-up").url,
                                   method: .post,
                                   parameters: [
                                    "userName": userName,
                                    "password": password,
                                    "language": "RU",
                                    "displayName": userName,
                                    "email": email
                                   ],
                                   success: success,
                                   failure: failure)
        }             
    }
}
