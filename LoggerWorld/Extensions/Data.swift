//
//  Data.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 25.11.2020.
//

import Foundation

extension Data {
    func decoded<T: Decodable>(_ type: T.Type) -> T? {
        let json = JSONDecoder()
        do {
            let jsonData = try json.decode(type.self, from: self)
            return jsonData
        } catch {
            print(NSString(data: self, encoding: 4) ?? "")
            print("Error to encode model \(T.self) (weight: \(self) to data: " + error.localizedDescription)
            return nil
        }
    }
}
