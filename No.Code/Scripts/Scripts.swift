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
    
}
