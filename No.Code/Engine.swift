//
//  Engine.swift
//  No.Code
//
//  Created by Сафир Михаил Дмитриевич [B] on 11.08.2022.
//

import Foundation
import Cocoa
import SwiftUI

public class Engine: NSObject {
    static let shared = Engine()
    
    func process(){
        let pasteboard = NSPasteboard.general
        var copiedString = pasteboard.string(forType: .string) ?? ""
        print("*** \(copiedString) ***")
        
        if (copiedString.contains("/encodeBase64")){
            copiedString = copiedString.replacingOccurrences(of: "/encodeBase64", with: "")
            copiedString = Scripts.toBase64(copiedString)
        }
        
        if (copiedString.contains("/decodeBase64")){
            copiedString = copiedString.replacingOccurrences(of: "/decodeBase64", with: "")
            copiedString = Scripts.fromBase64(copiedString)
        }
        
        if copiedString.contains("/toUTC") {
            copiedString = copiedString.replacingOccurrences(of: " ", with: "")
            copiedString = copiedString.replacingOccurrences(of: "/toUTC", with: "")
            copiedString = Scripts.toUTC(copiedString)
        }
        
        if copiedString.contains("/countWords") {
            copiedString = copiedString.replacingOccurrences(of: "/countWords", with: "")
            copiedString = copiedString + Scripts.countWord(copiedString)
        }
        
        if copiedString.contains("/countLines") {
            copiedString = copiedString.replacingOccurrences(of: "/countLines", with: "")
            copiedString = copiedString + Scripts.countLines(copiedString)
        }
        
        if copiedString.contains("/countChar") {
            copiedString = copiedString.replacingOccurrences(of: "/countChar", with: "")
            copiedString = copiedString + Scripts.countCharacter(copiedString)
        }
        
        if copiedString.contains("/jwt") {
            copiedString = copiedString.replacingOccurrences(of: "/jwt", with: "")
            copiedString = Scripts.jwtDetails(copiedString)
        }
        
        if copiedString.contains("/replace") {
            let cleanTextArray : [String] = copiedString.components(separatedBy: "/replace ")
            let cleanText = cleanTextArray.first
            let rules = cleanTextArray.last
            let rules_of = rules?.components(separatedBy: "\" \"").first?.replacingOccurrences(of: "\"", with: "")
            let rules_with = rules?.components(separatedBy: "\" \"").last?.replacingOccurrences(of: "\"", with: "")
            
            copiedString = Scripts.replace(cleanText!, of: rules_of!, with: rules_with!)
        }
        
        if copiedString.contains("/removeLines") {
            copiedString = copiedString.replacingOccurrences(of: "/removeLines", with: "")
            copiedString = Scripts.removeLines(copiedString)
        }
        
        if copiedString.contains("/breakWords") {
            copiedString = copiedString.replacingOccurrences(of: "/breakWords", with: "")
            copiedString = Scripts.breakWords(copiedString)
        }
        
        
        
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(copiedString, forType: .string)
    }
    
}
