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
        
        hotKeySelection.keyDownHandler = { [self] in
            copyShortCut()
        }
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.title = "No.Code"
        }
        
        setupMenus()
    }
    
    func setupMenus() {
        // 1
        let menu = NSMenu()
        // 2
        let one = NSMenuItem(title: "Run", action: #selector(didTapRun) , keyEquivalent: "d")
        
        menu.addItem(one)
        
        menu.addItem(NSMenuItem.separator())
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        // 3
        statusItem.menu = menu
    }
    
    private func changeStatusBarButton(number: Int) {
        
    }
    
    @objc func didTapRun() {
        changeStatusBarButton(number: 1)
    }
    
    func startProcess(){
        selectShortcut()
        print("selectShortcut done")
       
    }
}

func textProcess(){
    let pasteboard = NSPasteboard.general
    var copiedString = pasteboard.string(forType: .string) ?? ""
    
    if (copiedString.contains("/e64")){
        copiedString = copiedString.replacingOccurrences(of: "/e64", with: "")
        copiedString = copiedString.toBase64()
    }
    
    if (copiedString.contains("/d64")){
        copiedString = copiedString.replacingOccurrences(of: " ", with: "")
        copiedString = copiedString.replacingOccurrences(of: "/d64", with: "")
        copiedString = copiedString.fromBase64() ?? copiedString
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
        print("textProcess done")
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


extension String {

    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

}
