//
//  String.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation

extension String {
    
    // MARK: - Public properties
    
    var url: URL? {
        
        if isEmpty { return nil }
        
        let regEx = "[А-Яа-я]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        var string = ""
        
        forEach { (character) in
            let char = String(character)
            if predicate.evaluate(with: char) {
                string += char.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            } else {
                string += char
            }
        }
        
        return URL(string: string)
    }
}
