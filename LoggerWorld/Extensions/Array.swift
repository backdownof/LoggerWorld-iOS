//
//  Array.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 06.12.2020.
//

import Foundation

extension Array where Element: Equatable {

    mutating func remove(object: Element) {

        if let index = index(of: object) {

            remove(at: index)
        }
    }
}
