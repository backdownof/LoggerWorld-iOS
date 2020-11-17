//
//  Constant+Block.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 17.11.2020.
//

import UIKit

extension Constant {
    
    struct Block {
        
        typealias data = (Any?) -> Void
        typealias error = (ErrorHandler) -> Void
        typealias progress = (Float) -> Void
        typealias completion = () -> Void
        typealias result = (Bool) -> Void
        typealias string = (String) -> Void
        typealias date = (Date) -> Void
        typealias integer = (Int) -> Void
        
    }
    
}
