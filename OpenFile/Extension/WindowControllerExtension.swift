//
//  WindowControllerExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/27.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension NSWindowController {
    
    func show(_ sender: Any?) {
        window?.center()
        showWindow(sender)
        NSApp.activate(ignoringOtherApps: true)
        window?.makeKeyAndOrderFront(sender)
    }
    
}
