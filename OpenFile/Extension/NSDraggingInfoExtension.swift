//
//  NSDraggingInfoExtension.swift
//  OpenFile
//
//  Created by 侯猛 on 2019/12/23.
//  Copyright © 2019 侯猛. All rights reserved.
//

import Cocoa
import Foundation

extension NSDraggingInfo {
    
    var fileUrls: [URL] {
        guard let filenames = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String] else {
            return []
        }
        let urlGroup: [URL] = filenames.compactMapCustom { (urlString, _) -> URL? in
            return URL(fileURLWithPath: urlString)
        }
        return urlGroup
    }
    
    var filePaths: [String] {

        guard let filenames = draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType("NSFilenamesPboardType")) as? [String] else {
            return []
        }
        let pathGroup: [String] = filenames.compactMapCustom { (urlString, _) -> String? in
            return urlString
        }

        return pathGroup
//        return pathGroup.first == nil ? [] : [pathGroup.first!]
    }
    
    
}

