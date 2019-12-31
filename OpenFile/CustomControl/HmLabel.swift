//
//  HistoryThumbnailLabel.swift
//  uPic
//
//  Created by 侯猛 on 2019/11/26.
//  Copyright © 2019 Svend Jin. All rights reserved.
//

import Cocoa

class HmLabel: NSTextField {
    
    private var oldStringValue: String?
    
    private var oldTextColor: NSColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initializeView()
    }
    
    func initializeView() {
        oldStringValue = stringValue
        oldTextColor = textColor
        cell = VerticalCenteringCell()
        backgroundColor = .clear
        canDrawSubviewsIntoLayer = true
        alignment = .center
        isEditable = false
        stringValue = oldStringValue ?? ""
        textColor = oldTextColor
        oldStringValue = nil
        oldTextColor = nil
    }
    
}


class VerticalCenteringCell: NSTextFieldCell {
    override func titleRect(forBounds rect: NSRect) -> NSRect {
        var rect = super.titleRect(forBounds: rect)
        rect.origin.y += (rect.height - cellSize.height) / 2
        return rect
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: titleRect(forBounds: cellFrame), in: controlView)
    }
    
    override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        super.select(withFrame: titleRect(forBounds: rect), in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
    }

}
