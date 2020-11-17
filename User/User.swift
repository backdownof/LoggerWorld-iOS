//
//  User.swift
//  Talk
//
//  Created by Гороховский Никита on 20.10.2020.
//  Copyright © 2020 PUMPIT. All rights reserved.
//

import UIKit
import ObjectMapper

class User: NSObject, Mappable, NSSecureCoding {
    
    // MARK: - Public properties
    
    var firstName: String = ""
    var lastName: String = ""
    var avatar: String?
    var role: Int = 0
    var contacts: [Contact] = []
    
    // MARK: - Mappable
    
    required init?(map: Map) { super.init() }
    
    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        setup(coder: aDecoder)
    }
}
