//
//  HmButton.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/27.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

enum MouseType {
    case leftDown
    case leftUp
    case rightDown
    case rightUp
    case entered
    case exited
}

class HmButton: NSButton {
    
    private var trackingArea: NSTrackingArea?
    
    var mouseClickTypeHandler: ((MouseType) -> Void)?
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        removeTrackingArea()
        let options : NSTrackingArea.Options = [.mouseEnteredAndExited, .activeInKeyWindow]
        let newBounds = NSRect(x: 5, y: 5, width: bounds.width - 10, height: bounds.height - 10)
        trackingArea = NSTrackingArea(rect: newBounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(trackingArea!)
        
        guard var mouseLocation = window?.mouseLocationOutsideOfEventStream else {
            return
        }
        mouseLocation = convert(mouseLocation, from: nil)
        if NSPointInRect(mouseLocation, bounds) {
            mouseEntered(with: NSEvent())
        } else {
            mouseExited(with: NSEvent())
        }
    }
    
    private func removeTrackingArea() {
        if trackingArea != nil {
            removeTrackingArea(trackingArea!)
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func mouseDown(with event: NSEvent) {
//        super.mouseDown(with: event)
        mouseClickTypeHandler?(.leftDown)
    }
    
    override func mouseUp(with event: NSEvent) {
//        super.mouseUp(with: event)
        mouseClickTypeHandler?(.leftUp)
    }
    
    override func rightMouseDown(with event: NSEvent) {
        super.rightMouseDown(with: event)
        mouseClickTypeHandler?(.rightDown)
    }
    
    override func rightMouseUp(with event: NSEvent) {
//        super.rightMouseUp(with: event)
        mouseClickTypeHandler?(.rightUp)
    }
    
    override func mouseEntered(with event: NSEvent) {
//        super.mouseEntered(with: event)
        mouseClickTypeHandler?(.entered)
    }
    
    override func mouseExited(with event: NSEvent) {
//        super.mouseExited(with: event)
        mouseClickTypeHandler?(.exited)
    }
    
    
    
    
}
