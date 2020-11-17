//
//  UserSettings.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 17.11.2020.
//

import UIKit

class UserSettings: NSObject {
    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.token)
        }
        set {
            guard let value = newValue else {
                UserDefaults.standard.removeObject(forKey: Key.token)
                return
            }
            UserDefaults.standard.set(value, forKey: Key.token)
        }
    }
    
//    static var user: User? {
//        get {
//            guard let data = UserDefaults.standard.object(forKey: Key.user) as? Data else { return nil }
//            if #available(iOS 12, *) {
//                do {
//                    let user = try NSKeyedUnarchiver.unarchivedObject(ofClass: User.self, from: data)
//                    return user
//                } catch {
//                    print(error)
//                    return nil
//                }
//            } else {
//                return NSKeyedUnarchiver.unarchiveObject(with: data) as? User
//            }
//        }
//        set {
//            guard let value = newValue else {
//                UserDefaults.standard.removeObject(forKey: Key.user)
//                return
//            }
//            if #available(iOS 12, *) {
//                let data = try! NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
//                UserDefaults.standard.set(data, forKey: Key.user)
//            } else {
//                let data = NSKeyedArchiver.archivedData(withRootObject: value)
//                UserDefaults.standard.set(data, forKey: Key.user)
//            }
//        }
//    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: Key.token)
//        UserDefaults.standard.removeObject(forKey: Key.user)
    }
}
