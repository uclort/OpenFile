//
//  HmFileModel.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/25.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

struct HmMainFileModel {
    var path: String = ""
    var pathURL: URL {
        URL(fileURLWithPath: path)
    }
    var showName: String {
        guard let customNickname = customNickname, !customNickname.isEmpty else {
            return name
        }
        return customNickname
    }
    var name: String = ""
    var customNickname: String?
    var image: NSImage? {
        NSWorkspace.shared.icon(forFile: path)
    }
    
    init(path: String, customNickname: String?) {
        self.path = path
        name = URL(fileURLWithPath: path).lastPathComponent
        self.customNickname = customNickname
    }

}
