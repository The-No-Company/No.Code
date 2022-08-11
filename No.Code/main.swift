//
//  No_CodeApp.swift
//  No.Code
//
//  Created by Сафир Михаил Дмитриевич [B] on 09.08.2022.
//

import SwiftUI
import Cocoa
import KeyboardShortcuts
import HotKey


let app = NSApplication.shared
let appDelegate = AppDelegate()
app.delegate = appDelegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)

class AppDelegate: NSResponder, NSApplicationDelegate, ObservableObject {
    
    var statusItem: NSStatusItem!
    var window: NSWindow?
    let hotKey = HotKey(key: .one, modifiers: [.command, .shift])
    let hotKeySelection = HotKey(key: .two, modifiers: [.command, .shift])
    let hotKeyLine = HotKey(key: .l, modifiers: [.command, .shift])

    
    func applicationDidFinishLaunching(_ notification: Notification) {
        print("start application")
        
        NSApplication.shared.activate(ignoringOtherApps: true)
        
        
        hotKey.keyDownHandler = { [self] in
            startProcess()
        }
        
        hotKeySelection.keyDownHandler = {
            copyShortCut()
        }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.title = "No.Code"
        }
        
        setupMenus()
    }
    
    func setupMenus() {
        let menu = NSMenu()
        let one = NSMenuItem(title: "Run from selection", action: #selector(didTapRun) , keyEquivalent: "d")
        menu.addItem(one)
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    @objc func didTapRun() {
        copyShortCut()
    }
    
    func startProcess(){
        selectShortcut()
        print("selectShortcut done")
       
    }
}

func textProcess(){
    let pasteboard = NSPasteboard.general
    var copiedString = pasteboard.string(forType: .string) ?? ""
    print("*** \(copiedString) ***")
    
    if (copiedString.contains("/e64")){
        copiedString = copiedString.replacingOccurrences(of: "/e64", with: "")
        copiedString = Scripts.toBase64(copiedString)
    }
    
    if (copiedString.contains("/d64")){
        copiedString = copiedString.replacingOccurrences(of: "/d64", with: "")
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
    
    NSPasteboard.general.clearContents()
    NSPasteboard.general.setString(copiedString, forType: .string)
    
    pasteShortCut()
}

func selectShortcut() {
    
    let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)

    let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)
    let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
    let spcd = CGEvent(keyboardEventSource: src, virtualKey: 0x00, keyDown: true)
    let spcu = CGEvent(keyboardEventSource: src, virtualKey: 0x00, keyDown: false)

    spcd?.flags = CGEventFlags.maskCommand;

    let loc = CGEventTapLocation.cghidEventTap

    cmdd?.post(tap: loc)
    spcd?.post(tap: loc)
    spcu?.post(tap: loc)
    cmdu?.post(tap: loc)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
        copyShortCut()
        print("copyShortCut done")
    }

}

func copyShortCut(){
    let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)

    let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)
    let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
    let spcd = CGEvent(keyboardEventSource: src, virtualKey: 0x08, keyDown: true)
    let spcu = CGEvent(keyboardEventSource: src, virtualKey: 0x08, keyDown: false)

    spcd?.flags = CGEventFlags.maskCommand;

    let loc = CGEventTapLocation.cghidEventTap

    cmdd?.post(tap: loc)
    spcd?.post(tap: loc)
    spcu?.post(tap: loc)
    cmdu?.post(tap: loc)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
        textProcess()
    }
}


func pasteShortCut(){
    let src = CGEventSource(stateID: CGEventSourceStateID.hidSystemState)

    let cmdd = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: true)
    let cmdu = CGEvent(keyboardEventSource: src, virtualKey: 0x38, keyDown: false)
    let spcd = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: true)
    let spcu = CGEvent(keyboardEventSource: src, virtualKey: 0x09, keyDown: false)

    spcd?.flags = CGEventFlags.maskCommand;

    let loc = CGEventTapLocation.cghidEventTap

    cmdd?.post(tap: loc)
    spcd?.post(tap: loc)
    spcu?.post(tap: loc)
    cmdu?.post(tap: loc)
}
