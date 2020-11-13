//
//  ConstantsBroadcast.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 01.11.2020.
//

import Foundation

struct Constants {
    static let socketBaseUrl = "ws://192.168.1.65:5555"
    
    struct Segue {
        static let login = "login"
        static let selectedCharWhenLogin = "loggedInWithChar"
    }
    
    struct Cell {
        static let createdCharacters = "createdCharacters"
    }
    
    struct ActionTypes {
        static let registration = "registration"
        static let login = "login"
    }
}
