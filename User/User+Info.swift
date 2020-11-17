//
//  User+Info.swift
//  Talk
//
//  Created by Гороховский Никита on 20.10.2020.
//  Copyright © 2020 PUMPIT. All rights reserved.
//

import Foundation

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
    
    static var current: User? {
        get {
            return UserSettings.user
        }
        set {
            UserSettings.user = newValue
            NotificationCenter.default.post(name: .didChangeUser, object: nil)
        }
    }
}
