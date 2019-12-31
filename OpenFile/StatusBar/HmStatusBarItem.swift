//
//  HmStatusBarItem.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/23.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation
import MASShortcut

class HmStatusBarItem: NSObject {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    @IBOutlet weak var statusMenu: NSMenu!
    
    var preferencesWindowController: HmPreferencesWindowController = ContentStoryboard(Identifier: HmPreferencesWindowController.self)
    
    var contentWindowController: HmMainWindowController = ContentStoryboard(Identifier: HmMainWindowController.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingStatusBar()
    }
    
    func settingStatusBar() {
        
        guard let button = statusItem.button else { return }
        
        button.image = NSImage(named: "StatusBar")
        button.window?.delegate = self
        button.window?.registerForDraggedTypes([.fileURL])
        button.sendAction(on: [.leftMouseUp, .rightMouseUp, .leftMouseDown, .rightMouseDown])
        button.action = #selector(clickStatusItemButton)
        button.target = self
        
        statusItem.menu = nil
        
        bindSignal()
    }
    
    private func bindSignal() {
        MASShortcutBinder.shared()?.bindShortcut(withDefaultsKey: "showMainWindowHotKeyView") { [weak self] in
            guard let self = self, let button = self.statusItem.button else { return }
            if self.contentWindowController.window?.isMainWindow == true {
                self.contentWindowController.window?.orderOut(button)
            } else {
                self.contentWindowController.show(button: button)
            }
        }
    }
    
    @objc
    private func clickStatusItemButton() {
        guard let button = statusItem.button, let event = NSApp.currentEvent else { return }
        switch event.type {
        case .leftMouseUp:
            if contentWindowController.window?.isMainWindow == true {
                contentWindowController.window?.orderOut(button)
            } else {
                contentWindowController.show(button: button)
            }
        case .rightMouseUp:
            self.contentWindowController.window?.orderOut(button)
            self.statusItem.menu = statusMenu
            self.statusItem.button?.performClick(button)
            self.statusItem.menu = nil
        default:
            break
        }
    }
    
    @IBAction func openPreferencesWindow(_ sender: NSMenuItem) {
        preferencesWindowController.show(sender)
        
    }
    
    @IBAction func clearAddedFile(_ sender: NSMenuItem) {
        UserDefaults.cleanFilePaths()
        guard let contentViewController = contentWindowController.window?.contentViewController as? HmMainWindowContentViewController else {
            return
        }
        contentViewController.mainCollectionView.cleanAllFile()
    }
    
    @IBAction func exitApp(_ sender: NSMenuItem) {
        NSApp.terminate(self)
    }
    
}

extension HmStatusBarItem: NSWindowDelegate, NSDraggingDestination {
    func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        contentWindowController.show(button: statusItem.button)
        return .generic
    }
    
    func draggingExited(_ sender: NSDraggingInfo?) {
        statusItem.button?.window?.unregisterDraggedTypes()
    }
    
    func draggingEnded(_ sender: NSDraggingInfo) {
        statusItem.button?.window?.registerForDraggedTypes([.fileURL])
    }
    
}
