//
//  ColorExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension NSColor {
    class var textColor: NSColor {
        return isDarkMode ? .white : .black
    }
    
    class func Hex(_ Hexadecimal: UInt32, _ alpha: CGFloat = 1.0) -> NSColor {
        return NSColor(red: CGFloat((Hexadecimal & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((Hexadecimal & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(Hexadecimal & 0x0000FF) / 255.0,
                       alpha: CGFloat(alpha))
    }
    
    func alpha(_ alpha: CGFloat) -> NSColor {
        return withAlphaComponent(alpha)
    }
}
