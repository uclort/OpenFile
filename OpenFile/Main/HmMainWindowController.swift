//
//  HmWindowController.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

class HmMainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    }
    
    func show(button: NSButton?) {
        
        guard let button = button, let buttonWindow = button.window, let window = self.window else { return }
        let frameOrigin = buttonWindow.frame.origin
        
        let screenWidth = NSScreen.main?.frame.width ?? 0
        let screenHeight = NSScreen.main?.frame.height ?? 0
        let screenY = NSScreen.main?.frame.origin.y ?? 0
        let screenMinX = CGFloat((NSScreen.main?.frame.origin.x ?? 0))
        let screenMaxX = screenMinX + screenWidth
        var left = (frameOrigin.x + button.bounds.width * 0.5) - window.frame.width * 0.5
        let right = (frameOrigin.x + button.bounds.width * 0.5) + window.frame.width * 0.5
        let top = screenHeight - 322 + screenY
        
        if right > screenMaxX {
            left = left - ((right - screenMaxX) + 10)
        } else if left < screenMinX {
            left = screenMaxX - window.frame.width - 10
        }
        
        
        let yourPoint = CGPoint(x: left, y: top)
        window.setFrameOrigin(yourPoint)
        NSApp.activate(ignoringOtherApps: true)
        showWindow(NSScreen.main)
        window.makeKeyAndOrderFront(NSScreen.main)
        
    }
}
