//
//  HmTool.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

func ContentStoryboard<T>(Identifier: AnyClass) -> T {
    let storyboard = NSStoryboard(name: "ContentStoryboard", bundle: nil)
    return storyboard.instantiateController(withIdentifier: String(describing: Identifier.self)) as! T
}

var isDarkMode: Bool {
    if #available(OSX 10.14, *) {
        let apperance = NSApp.effectiveAppearance
        return apperance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
    } else {
        // Fallback on earlier versions
        return false
    }
}
