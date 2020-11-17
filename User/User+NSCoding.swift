//
//  User+NSCoding.swift
//  Talk
//
//  Created by Гороховский Никита on 20.10.2020.
//  Copyright © 2020 PUMPIT. All rights reserved.
//

import Foundation

extension User {
    
    static var supportsSecureCoding: Bool {
        return true
    }
    
    func setup(coder aDecoder: NSCoder) {
        firstName = aDecoder.decodeObject(forKey: Key.firstName) as? String ?? ""
        lastName = aDecoder.decodeObject(forKey: Key.lastName) as? String ?? ""
        avatar = aDecoder.decodeObject(forKey: Key.avatar) as? String
        role = aDecoder.decodeInteger(forKey: Key.role) as Int
        contacts = aDecoder.decodeObject(of: [NSArray.self, Contact.self], forKey: Key.contacts) as! [Contact]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(firstName, forKey: Key.firstName)
        aCoder.encode(lastName, forKey: Key.lastName)
        aCoder.encode(avatar, forKey: Key.avatar)
        aCoder.encode(role, forKey: Key.role)
        aCoder.encode(contacts, forKey: Key.contacts)
    }
}
