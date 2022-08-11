//
//  Scripts.swift
//  No.Code
//
//  Created by Анисимов Кирилл Александрович [B] on 11.08.2022.
//

import Foundation

let defaultError = "incorrect input"

struct Scripts {
    
    //MARK: - Base64
    static func fromBase64(_ input: String) -> String {
        if !input.isEmpty {
            let res = input.replacingOccurrences(of: " ", with: "")
            return res.fromBase64() ?? defaultError
        }
        return defaultError
    }
    
    static func toBase64(_ input: String) -> String {
        if !input.isEmpty {
            return input.toBase64()
        }
        return defaultError
    }
    
    
    //MARK: - Date converting
    static func toUTC(_ input: String) -> String {
        if let timeResult = Double(input) {
            let date = Date(timeIntervalSince1970: timeResult)
            return date.description
        }
        return defaultError
    }
    
    // MARK: - Count words, lines, characters
    static func countWord(_ input: String) -> String {
        if !input.isEmpty {
            let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
            let components = input.components(separatedBy: chararacterSet)
            let words = components.filter { !$0.isEmpty }
            return String("(\(words.count))")
        }
        return defaultError
    }
    
    static func countLines(_ input: String) -> String {
        if !input.isEmpty {
            return String("(\(input.numberOfLines()))")
        }
        return defaultError
    }
    
    static func countCharacter(_ input: String) -> String {
        if !input.isEmpty {
            let noSpace = input.replacingOccurrences(of: " ", with: "")
            return String("(\(noSpace.count))")
        }
        return defaultError
    }
    
    static func jwtDetails(_ input: String) -> String {
        if !input.isEmpty {
            let noSpace = input.replacingOccurrences(of: " ", with: "")
            if let data = noSpace.slice(from: ".", to: ".") {
                if let decodedData = data.base64Decoded() {
                    return decodedData
                }
            }
        }
        return defaultError
    }
    
    static func replace(_ input: String, of: String, with: String) -> String {
        if !input.isEmpty {
            let replaced = input.replacingOccurrences(of: of, with: with)
            return replaced
        }
        return defaultError
    }
    
    static func removeLines(_ input: String) -> String {
        if !input.isEmpty {
            let noLine = input.replacingOccurrences(of: "\n", with: " ")
            return noLine
        }
        return defaultError
    }
    
    static func breakWords(_ input: String) -> String {
        if !input.isEmpty {
            let allWords : [String] = input.components(separatedBy: " ")
            var result = ""
            allWords.forEach { word in
                result += word
                result += "\n"
            }
            return result
        }
        return defaultError
    }
    
}
