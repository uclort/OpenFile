//
//  DragDropView.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa

class HmMainDragDropView: NSView {
    
    var dragDropToComplete: (([String]) -> Void)?
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        registerForDraggedTypes([.fileURL])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        alphaValue = 1
        return .copy
    }
    
    override func draggingUpdated(_ sender: NSDraggingInfo) -> NSDragOperation {
        return self.draggingEntered(sender)
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        alphaValue = 0
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return true
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        dragDropToComplete?(sender.filePaths)
        alphaValue = 0
        return true
    }
}
