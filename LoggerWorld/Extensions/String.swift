//
//  String.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 18.11.2020.
//

import Foundation

extension String {
    
    // MARK: - Public properties
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
    
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
    
    func groups(for regexPattern: String) throws -> [[String]] {
//        do {
            let text = self
            let regex = try NSRegularExpression(pattern: regexPattern)
            let matches = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return matches.map { match in
                return (0..<match.numberOfRanges).map {
                    let rangeBounds = match.range(at: $0)
                    guard let range = Range(rangeBounds, in: text) else {
                        return ""
                    }
                    return String(text[range])
                }
            }
        }
//        catch let error {
//            print("invalid regex: \(error.localizedDescription)")
//            return []
//        }
//    }
}
