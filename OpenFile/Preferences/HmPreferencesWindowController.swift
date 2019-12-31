//
//  HmPreferencesWindowController.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/27.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

class HmPreferencesWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}

extension HmPreferencesWindowController: NSWindowDelegate {
    
    func windowWillBeginSheet(_ notification: Notification) {
    }
    
    func windowWillClose(_ notification: Notification) {
        // 关闭偏好设置时在去掉 Dock 栏显示应用图标
        NSApp.setActivationPolicy(.accessory)
    }
}
