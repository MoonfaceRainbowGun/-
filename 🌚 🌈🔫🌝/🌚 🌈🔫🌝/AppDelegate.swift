//
//  AppDelegate.swift
//  🌚 🌈🔫🌝
//
//  Created by Lei Mingyu on 18/8/17.
//  Copyright © 2017 MFRG. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system().statusItem(withLength: 40)
    var themeMenu: NSMenu!

    let configs = ["mechanical-keyboard", "pentatonic", "easter-eggs", "midi", "git", "voice", "command-line", "pentatonic", "xwlb"]
    let titles = ["Mechanical Keyboard", "Pentatonic","Easter Eggs", "MIDI", "Git Keywords", "Voice Over", "Bash Keywords", "Musician", "新闻联播"]
    var selected = [false, false, false, false, false, false, false, false, false]

    var processors = [Int: MFProcessor]()

	
    func applicationWillFinishLaunching(_ notification: Notification) {
		
        self.retrieveUserSettings()
		
        self.configureMenu()

		MFKeyboardEventManager.sharedInstance.startListening()
		MFCharacterEventManager.sharedInstance.startListening()
    }
    
    func configureMenu() {
        if let button = statusItem.button {
            button.image = NSImage(named: "ic_keyboard")
        }
        
        let menu = NSMenu()
        
        menu.addItem(self.getThemeMenuItem())
        menu.addItem(self.getQuitMenuItem())

        statusItem.menu = menu
    }
    
    func getQuitMenuItem() -> NSMenuItem {
        let quit = NSMenuItem(title: "Quit", action: #selector(terminateApplication), keyEquivalent: "Q")
        return quit;
    }
    
    func getThemeMenuItem() -> NSMenuItem {
        let themeItem = NSMenuItem()
        themeItem.title = "Theme"
        
        let themeMenu = NSMenu()
        
        for (index, title) in titles.enumerated() {
            let item = NSMenuItem(title: title, action: #selector(themeDidSelect(sender:)), keyEquivalent: "\(index + 1)")
            item.tag = index;
            themeMenu.addItem(item)
            
            if self.selected[index] {
                item.state = NSOnState
                let rule = Rule(plistName: self.configs[index])
                let processor = MFProcessor(keyEventBuffer: MFBuffer(), rule: rule)
                self.processors[index] = processor
            }
        }
        
        themeItem.submenu = themeMenu
		
        self.themeMenu = themeMenu
        return themeItem;
    }

    func themeDidSelect(sender: NSMenuItem) {
		
		defer {
			self.saveUserSettings()
		}
		
        for menuItem in self.themeMenu.items {
            if menuItem == sender {
                let tag = menuItem.tag
                self.selected[tag] = !self.selected[tag]
                menuItem.state = self.selected[tag] ? NSOnState : NSOffState
                if (self.selected[tag]) {
                    let rule = Rule(plistName: self.configs[tag])
                    let processor = MFProcessor(keyEventBuffer: MFBuffer(), rule: rule)
                    self.processors[tag] = processor
                } else {
                    self.processors[tag] = nil
                }
            }
        }
    }
    
    func saveUserSettings() {
        UserDefaults.standard.set(self.selected, forKey: "record");
    }
    
    func retrieveUserSettings() {
        if let record = UserDefaults.standard.array(forKey: "record") as? [Bool] {
            self.selected = record
        }
    }
    
    func terminateApplication() {
        exit(0)
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }


}
