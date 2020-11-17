//
//  User+Data.swift
//  Talk
//
//  Created by Гороховский Никита on 20.10.2020.
//  Copyright © 2020 PUMPIT. All rights reserved.
//

import Foundation

extension User {
    
    // MARK: - Public methods
    
    @discardableResult
    static func profile(completion: Constant.Block.completion? = nil,
                        failure: Constant.Block.error? = nil) -> DataOperation? {
        return API.User.profile(success: { (json) in
            
            User.readAndSaveProfile(
                json: json,
                completion: completion,
                failure: failure
            )
        }, failure: failure)
    }
    
    // MARK: - Private methods
    
    private static func readAndSaveProfile(json: Any?,
                                            completion: Constant.Block.completion?,
                                            failure: Constant.Block.error?) {
        Parser.parse(json: json,
                     mappable: User.self,
                     success: { (data) in
                        
                        if let user = data as? User {
                            User.current = user
                            completion?()
                            
                        } else {
                            failure?(Parser.error)
                        }
                     },
                     failure: failure)
    }
}
